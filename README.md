# Terraform Project Structure

This project contains Terraform configurations for deploying infrastructure. Below is an overview of the project structure and purpose of each file.

## GitHub Actions Integration

This project uses GitHub Actions for automating Terraform deployments, managing state, and applying changes to the Azure infrastructure. GitHub Actions is configured to automate deployments for both Windows and Linux environments using separate workflows.

### Setting Up GitHub Actions

To set up GitHub Actions for this project, follow these steps:

1. **Create GitHub Secrets**:
   - Navigate to **Settings** -> **Secrets and variables** -> **Actions** in your GitHub repository.
   - Add the following secrets for your Azure credentials:

     | Secret Name                  | Description                                                     |
     |------------------------------|-----------------------------------------------------------------|
     | `AZURE_SUBSCRIPTION_ID`      | Your Azure Subscription ID                                      |
     | `AZURE_CLIENT_ID`            | Client ID for the Service Principal                             |
     | `AZURE_CLIENT_SECRET`        | Client Secret for the Service Principal                         |
     | `AZURE_TENANT_ID`            | Tenant ID for your Azure Active Directory                       |


2. **Create GitHub Workflows**:
   - Place the following YAML files in the `.github/workflows/` directory.

# Terraform Project Structure

This project contains Terraform configurations for deploying infrastructure. Below is an overview of the project structure and purpose of each file.

## Prerequisites

Before using these configurations, ensure you have the following prerequisites set up:

1. **Terraform**: Install Terraform CLI (`>= v1.0.0`).
2. **Azure CLI**: Install Azure CLI to authenticate with Azure (`az login`).
3. **GitHub Secrets**: Set up GitHub Secrets for automating deployments (if using GitHub Actions).

### GitHub Secrets Required

| Secret Name                 | Description                                                    |
|-----------------------------|----------------------------------------------------------------|
| `AZURE_SUBSCRIPTION_ID`      | Your Azure Subscription ID                                     |
| `AZURE_CLIENT_ID`            | Client ID for the Service Principal                            |
| `AZURE_CLIENT_SECRET`        | Client Secret for the Service Principal                        |
| `AZURE_TENANT_ID`            | Tenant ID for your Azure Active Directory                      |

## Usage Instructions

### Step 1: Create a Storage Account

Before deploying any VMs, you need to create a storage account using the `storage_account` module. This storage account will be used to store the Terraform state file, enabling collaboration and state management.

1. **Create a `main.tf` file in the root directory** with the following content:

    ```hcl
    module "storage_account" {
      source              = "./modules/storage_account"
      resource_group_name = "example-resources"
      location            = "eastus"
      storage_account_name = "examplestoracc"
      container_name      = "tfstate"
    }
    ```

2. **Initialize Terraform**:

    ```bash
    terraform init
    ```

3. **Apply the configuration** to create the storage account:

    ```bash
    terraform apply -auto-approve
    ```

4. **Update the `backend.tf` file** in the `linux` or `windows` directories to use the newly created storage account. Replace the placeholders in the `backend.tf` file with the actual values:

    ```hcl
    terraform {
      backend "azurerm" {
        resource_group_name  = "example-resources"
        storage_account_name = "examplestoracc"
        container_name       = "tfstate"
        key                  = "linux-vm.tfstate" # Or "windows-vm.tfstate"
      }
    }
    ```

### Step 2: Deploy a Linux Virtual Machine (Manually)

1. Navigate to the `linux` directory:

    ```bash
    cd linux
    ```

2. **Update the `variables.tf` file** with your desired values (e.g., `vm_size`, `admin_username`, etc.).

3. **Initialize Terraform**:

    ```bash
    terraform init
    ```

4. **Plan the configuration** to see the changes:

    ```bash
    terraform plan
    ```

5. **Apply the configuration** to create the Linux VM:

    ```bash
    terraform apply -auto-approve
    ```

6. **Verify the VM Deployment** in the Azure portal.

### Step 3: Deploy a Windows Virtual Machine

1. Navigate to the `windows` directory:

    ```bash
    cd windows
    ```

2. **Update the `variables.tf` file** with your desired values (e.g., `vm_size`, `admin_username`, etc.).

3. **Initialize Terraform**:

    ```bash
    terraform init
    ```

4. **Plan the configuration** to see the changes:

    ```bash
    terraform plan
    ```

5. **Apply the configuration** to create the Windows VM:

    ```bash
    terraform apply -auto-approve
    ```

6. **Verify the VM Deployment** in the Azure portal.

## GitHub Actions Integration

This project uses GitHub Actions for automating Terraform deployments, managing state, and applying changes to the Azure infrastructure. GitHub Actions is configured to automate deployments for both Windows and Linux environments using separate workflows.

### Setting Up GitHub Actions

1. **Create GitHub Secrets**:
   - Navigate to **Settings** -> **Secrets and variables** -> **Actions** in your GitHub repository.
   - Add the following secrets for your Azure credentials as described in the prerequisites section.

2. **Create GitHub Workflows**: (GitHub Actions)
   - Place the following YAML files in the `.github/workflows/` directory.

#### Workflow for Linux VM Deployment (`deploy-linux.yml`)

```yaml
name: "Terraform Linux VM Deployment"

on:
  push:
    paths:
      - "linux/**"
  pull_request:
    paths:
      - "linux/**"

jobs:
  terraform:
    name: "Terraform Linux VM"
    runs-on: ubuntu-latest

    steps:
      - name: "Checkout Repository"
        uses: actions/checkout@v3

      - name: "Set up Terraform"
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.3.0

      - name: "Terraform Init"
        run: terraform init
        working-directory: linux/
        env:
          ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
          ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
          ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: "Terraform Plan"
        run: terraform plan
        working-directory: linux/

      - name: "Terraform Apply"
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
        working-directory: linux/```



#Directory

## Linux Directory

**Path:** `linux/`

- **backend.tf**: Defines the backend configuration for state management. 
- **main.tf**: Main configuration file that defines the core infrastructure resources. 
- **outputs.tf**: Outputs file that defines the output values to be displayed after the execution. 
- **variables.tf**: Input variables file that defines the variables used in this configuration. 


## Windows Directory

**Path:** `linux/`

- **backend.tf**: Defines the backend configuration for state management. 
- **main.tf**: Main configuration file that defines the core infrastructure resources. 
- **outputs.tf**: Outputs file that defines the output values to be displayed after the execution. 
- **variables.tf**: Input variables file that defines the variables used in this configuration. 
