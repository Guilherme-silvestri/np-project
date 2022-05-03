 #Criação de novo Resource Group
 

#Grupo de Recurso existente
/*
 data "azurerm_resource_group" "RG_PS_TW" {
  name = var.Res_Group
 }

 output "ba7fd646-5f3f-432c-bbc2-32baba6a423d" {
  value = var.Res_Group
 }*/


#Rede Virtual Azure
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-landpage"
  location            = var.locat
  resource_group_name = var.Res_Group
  address_space       = var.address_vnet
  tags                = var.tags
}



#Subrede Azure

resource "azurerm_subnet" "vlan1" {
    name                 = "vlan1-landpage"
    resource_group_name  = var.Res_Group
    virtual_network_name = var.name_vnet
    address_prefixes     = var.ip_vlan_01
    service_endpoints    = [ "Microsoft.Sql" ]
    
    depends_on = [
      azurerm_virtual_network.vnet
    ]

  }

  resource "azurerm_subnet" "vlan2" {
    name                 = "vlan2-landpage"
    resource_group_name  = var.Res_Group
    virtual_network_name = var.name_vnet
    address_prefixes     = var.ip_vlan_02
    service_endpoints    = [ "Microsoft.Sql" ]

    depends_on           = [
      azurerm_virtual_network.vnet
    ]

  }

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = "sql-vnet-rule"
  resource_group_name = var.Res_Group
  server_name         = azurerm_sql_server.server-landpage.name
  subnet_id           = azurerm_subnet.vlan1.id
  depends_on          = [
    azurerm_subnet.vlan1, azurerm_sql_server.server-landpage
  ]
}

#NSG - Grupo de Segurança de Rede

resource "azurerm_network_security_group" "nsg-landpage" {
  name = "NSG-landpage"
  location            = var.locat
  resource_group_name = var.Res_Group
  depends_on          = [
    azurerm_sql_server.server-landpage
  ]

    security_rule {
    name                       = "SQL_Out"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.249.2.0/23"
    destination_address_prefix = "10.249.0.0/23"
  }
    security_rule {
    name                       = "SQL_In"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.249.0.0/23"
    destination_address_prefix = "10.249.2.0/23"
  }
  tags = var.tags
}

#IP Público
/*resource "azurerm_public_ip" "pip-landpage" {
  name                = "pip-landpage"
  location            = var.locat
  resource_group_name = var.Res_Group
  allocation_method   = "Dynamic"  

  tags = var.tags
}*/

