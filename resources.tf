
#DATA_BASE

resource "azurerm_sql_server" "server-landpage" {
  name                         = "server-landpage"
  resource_group_name          = var.Res_Group
  location                     = var.locat
  version                      = "12.0"
  administrator_login          = "landpage"
  administrator_login_password = "serverlp_p455w0rd"

  tags = var.tags
}

resource "azurerm_sql_database" "db-landpage" {
  name                             = "db-landpage"
  resource_group_name              = var.Res_Group
  location                         = var.locat
  server_name                      = azurerm_sql_server.server-landpage.name
  max_size_bytes                   = "107374182400"
  max_size_gb                      = "100"
  requested_service_objective_name = "S3"
  depends_on                       = [
    azurerm_sql_server.server-landpage
  ]
  
   tags = var.tags
}
#Azure APP Service

resource "azurerm_app_service_plan" "app-plan" {
    name                = "landpage-app-plan"
    location            = var.locat
    resource_group_name = var.Res_Group

    sku {
      tier              = "Standard"
      size              = "S1"
      capacity          = 1
    }

  tags = var.tags
}


resource "azurerm_app_service" "app-service" {
    name                        = "landpage-app-service"
    location                    = var.locat
    resource_group_name         = var.Res_Group
    app_service_plan_id         = azurerm_app_service_plan.app-plan.id
    
    site_config {
        dotnet_framework_version = "v4.0"
        scm_type                 = "LocalGit"
        vnet_route_all_enabled   = true
    }

    app_settings = {
      "SOME_KEY" = "some-value"
    }

  tags = var.tags
}

/*resource "azurerm_app_service_virtual_network_swift_connection" "app-service-lan" {
  app_service_id = azurerm_app_service.app-service.id
  subnet_id      = azurerm_subnet.vlan1.id
  depends_on = [
    azurerm_app_service.app-service
  ]

 }*/