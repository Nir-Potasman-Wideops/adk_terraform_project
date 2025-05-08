# Get client_secrets.json:
* Go to the Google Cloud Console.
* Navigate to "APIs & Services" > "Credentials".
* Click "Create Credentials" > "OAuth client ID".
* Choose "Desktop app" as the Application type.
* Give it a name (e.g., "Desktop Client 1").
* Click "Create".
* Download the JSON file and save it as client_secrets.json in the same directory as your Python script.

-------------------------

# Running the terraform script:
To run the Terraform configuration in cloud_function_builder.tf, follow these steps:

* PROJECT-ID: nir-test-443507

In your root Terraform configuration:
```terraform
module "cloud_function" {
  source     = "./gcp-cloud-function"
  project_id = "your-gcp-project-id"
  region     = "us-central1"
  function_name = "hello-function"
  entry_point   = "hello_world"
}
```