# terraform-demo
`terraform version` 试试看安装了terraform没有
`gcloud auth application-default login` 设置google默认账户登陆

创建iac文件夹
文件夹下方包括provider.tf(让terraform安装与云平台对应的资源处理工具)和main.tf（用来创建资源的具体代码）
上述两个文件和文件夹创建好之后，运行`terraform init`初始化terraform，运行`terraform plan`查看terraform根据main.tf计划进行的操作，`terraform apply`将plan的操作全部实施。

### 变量
跟main.tf同位置创建variables.tf文件，里面添加要变量化的变量，如variable或project_id。然后将main.tf和provider.tf文件中，所有需要用变量代替的用${var.project_id}类似这样的变量名代替。然后创建tfvars文件夹，文件夹中创建dev.tfvars文件，里面定义变量的值，比如`location = "europe-west1"`。在运行的时候，如果你要让文件中的变量，都取dev.tfvars中定义的值，运行命令为`terraform plan -var-file=tfvars/dev.tfvars`。

### Workspace
创建新的workspace dev：`terraform workspace new dev`
创建新的workspace prod：`terraform workspace new prod`
所以在刚刚tfvars文件夹中的dev.tfvars里面定义的是dev环境中的变量。同理，我们可以给prod环境设置一套相应的变量保存在tfvars/prod.tfvars中。
另外main.tf和provider.tf中的资源名称，也可以加上-${terraform.workspace}这样的后缀，来区别每个环境下，管理和使用的资源是不一样的。
选择dev的工作环境：`terraform workspace select dev`
在dev环境中运行dev变量设置的terraform：`terraform apply -var-file=tfvars/dev.tfvars`

选择prod的工作环境：`terraform workspace select prod`
在prod环境中运行prod变量设置的terraform：`terraform apply -var-file=tfvars/prod.tfvars`

### 删除terraform创建的所有资源
选择dev环境：`terraform workspace select dev`
删除dev环境的所有资源：`terraform destroy -var-file=tfvars/dev.tfvars`

选择prod环境：`terraform workspace select prod`
删除prod环境的所有资源：`terraform destroy -var-file=tfvars/prod.tfvars`
