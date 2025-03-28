# IAM members recipe

<!-- These files are auto generated -->

## Properties

| Property | Description | Type | Required | Default | Pattern |
| -------- | ----------- | ---- | -------- | ------- | ------- |
| iam_members | [Module](https://github.com/terraform-google-modules/terraform-google-iam) | object | false | - | - |
| iam_members.*pattern* | - | array(object) | false | - | ^storage_bucket\|project\|organization\|folder\|service_account$ |
| iam_members.*pattern*.bindings | Map of IAM role to list of members to grant access to the role. | object | false | - | - |
| iam_members.*pattern*.bindings.*pattern* | - | array(string) | false | - | .+ |
| iam_members.*pattern*.project_id | ID of the project where the resources belong. Currently only required when the resource type is service account. | string | false | - | - |
| iam_members.*pattern*.resource_ids | ID of resources to assign the bindings.<br><br>Should be the following for each resource type: project: project IDs. e.g. [example_project_id] storage_bucket: storage bucket names. e.g. [example_bucket_one, example_bucket_two] folder: folder IDs. e.g. [12345678] organization: organizations IDs. e.g [12345678] service_account: service account emails. e.g [example-sa@example.iam.gserviceaccount.com] | array(string) | false | - | - |
