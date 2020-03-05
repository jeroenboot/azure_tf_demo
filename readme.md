https://learn.hashicorp.com/terraform/azure/intro_az
https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_certificate.html


Create the (client) certificate
```
$ openssl req -newkey rsa:4096 -nodes -keyout "service-principal.key" -out "service-principal.csr"


jeroenboot@YWCMac076 terraform and azure demo % openssl req -newkey rsa:4096 -nodes -keyout "service-principal.key" -out "service-principal.csr"  
Generating a 4096 bit RSA private key
................................................................++
.......................................++
writing new private key to 'service-principal.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:NL
State or Province Name (full name) []:Noord-Holland
Locality Name (eg, city) []:Hoorn
Organization Name (eg, company) []:homelab
Organizational Unit Name (eg, section) []:
Common Name (eg, fully qualified host name) []:
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
```




Init Terraform
```
jeroenboot@YWCMac076 terraform and azure demo % terraform init -var-file=secrets.tfvars     

Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Plan Terraform
```
jeroenboot@YWCMac076 terraform and azure demo % terraform plan -var-file=secrets.tfvars   
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "TerraformRG"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

Apply Terraform
```
jeroenboot@YWCMac076 terraform and azure demo % terraform apply -var-file=secrets.tfvars

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "TerraformRG"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 0s [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
Destroy
```
jeroenboot@YWCMac076 terraform and azure demo % terraform destroy -var-file=secrets.tfvars
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be destroyed
  - resource "azurerm_resource_group" "rg" {
      - id       = "/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG" -> null
      - location = "westeurope" -> null
      - name     = "TerraformRG" -> null
      - tags     = {} -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.rg: Destroying... [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG, 10s elapsed]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG, 20s elapsed]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG, 30s elapsed]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/ea98c2e6-c105-4ca2-b7ba-xxxxxxxxxxxx/resourceGroups/TerraformRG, 40s elapsed]
azurerm_resource_group.rg: Destruction complete after 45s

Destroy complete! Resources: 1 destroyed.
jeroenboot@YWCMac076 terraform and azure demo % 
```