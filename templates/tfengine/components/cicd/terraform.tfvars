{{- /* Copyright 2021 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */ -}}
{{$props := .__schema__.properties -}}
{{$envsProps := $props.envs.items.properties -}}
{{$triggerProps := $envsProps.triggers.properties -}}
parent_id         = "{{.parent_id}}"
parent_type       = "{{.parent_type}}"
billing_account   = "{{.billing_account}}"
project_id        = "{{.project_id}}"
scheduler_region  = "{{.scheduler_region}}"
state_bucket      = "{{.state_bucket}}"
terraform_root    = "{{.terraform_root}}"
{{hclField . "grant_automation_billing_user_role" -}}
{{hclField . "build_editors"}}
{{hclField . "build_viewers"}}
{{- if has . "cloud_source_repository"}}
cloud_source_repository = {
  name = "{{.cloud_source_repository.name}}"
  readers = [
    {{- range (get . "cloud_source_repository.readers" nil)}}
    "{{.}}",
    {{- end}}
  ]
  writers = [
    {{- range (get . "cloud_source_repository.writers" nil)}}
    "{{.}}",
    {{- end}}
  ]
}
{{- end}}
{{- if has . "github"}}
github = {
  owner = "{{.github.owner}}"
  name = "{{.github.name}}"
}
{{- end}}
envs = [
  {{- range get . "envs" -}}
  {{- $managed_dirs := ""}}
  {{- range .managed_dirs}}
  {{- $managed_dirs = trimSpace (printf "%s %s" $managed_dirs .)}}
  {{- end}}
  {
    branch_name = "{{.branch_name}}"
    managed_dirs = "{{$managed_dirs}}"
    name = "{{.name}}"
    triggers = {
        validate = {
          {{- if has .triggers "validate"}}
          skip = false
          run_on_push = {{get .triggers.validate "run_on_push" $triggerProps.validate.properties.run_on_push.default}}
          run_on_schedule = "{{get .triggers.validate "run_on_schedule" ""}}"
          {{- else}}
          skip = true
          run_on_push = false
          run_on_schedule = ""
          {{- end}}
        }
        plan = {
          {{- if has .triggers "plan"}}
          skip = false
          run_on_push = {{get .triggers.plan "run_on_push" $triggerProps.plan.properties.run_on_push.default}}
          run_on_schedule = "{{get .triggers.plan "run_on_schedule" ""}}"
          {{- else}}
          skip = true
          run_on_push = false
          run_on_schedule = ""
          {{- end}}
        }
        apply = {
          {{- if has .triggers "apply"}}
          skip = false
          run_on_push = {{get .triggers.apply "run_on_push" $triggerProps.apply.properties.run_on_push.default}}
          run_on_schedule = "{{get .triggers.apply "run_on_schedule" ""}}"
          {{- else}}
          skip = true
          run_on_push = false
          run_on_schedule = ""
          {{- end}}
        }
    }
  },
  {{- end}}
]
