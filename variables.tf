
#Variavel da Região do Azure
variable "locat" {
    default = "brazilsouth"
    type = string
}

#Variavel do grupo de recurso Azure
variable "Res_Group" {
    default = "RG_LANDPAGE"
    type    = string
  
}

#Variavel das Tags - podendo forçar o tipo de informação preenchida no terraform.tfvars
variable "tags" {
    type          = object( 
        {
        ProjectName = string
        Dep_Responsavel = string
        Responsavel_Interno = string
        CC        = string
        Ambiente = string
    })
}

#Variavel da Vnet do grupo de recurso
variable "name_vnet" {
    default = "vnet-landpage" 
}

#Variavel do range de IP da rede Vnet
variable "address_vnet" {
    default = [ "10.0.0.0/8" ]
  
}
#Variavel da subnet do grupo de recurso
variable "vlan1" {
    default = "vlan1-landpage"
  
}
variable "vlan2" {
    default = "vlan2-landpage"
  
}

#Variavel do range de IP da rede subrede/VLAN
variable "ip_vlan_01" {
    default = [ "10.249.0.0/23" ]
}
variable "ip_vlan_02" {
    default = [ "10.249.2.0/23" ]
}