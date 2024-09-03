# General local variables
locals {
  resource_prefix = "cg"

  # Use the Azure CAF naming provider to generate default resource name. (booleon)
  use_caf_naming = true

  location       = "uksouth"
  location_short = "uks"
}

# Resource group module

# VNet module
locals {
  address_space = ["10.0.0.0/16"]

  subnets = {
    app = {
      address_prefixes  = ["10.0.0.0/20"]
      service_endpoints = null
      delegation        = null
    }
    db = {
      address_prefixes  = ["10.0.16.0/20"]
      service_endpoints = ["Microsoft.Storage"]
      delegation = {
        name = "fs"
        service_delegation = {
          name = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }
    }
    appgw = {
      address_prefixes  = ["10.0.32.0/24"]
      service_endpoints = null
      delegation        = null
    }
    # new = {
    #   address_prefixes = ["10.0.48.0/20"]
    #   service_endpoints = null
    #   delegation        = null
    # }
  }

  # Network security groups
  nsg_list = {
    app = {
      nsg_name = "app-nsg"
    }
    db = {
      nsg_name = "db-nsg"
    }
    appgw = {
      nsg_name = "appgw-nsg"
    }
    # new = {
    #   nsg_name = "new-nsg"
    # }
  }

  # Network security groups rules
  security_rules = {
    "app" = [
      #{
      #   name                       = "Allow_HTTP"
      #   description                = "Allow_HTTP"
      #   priority                   = 105
      #   direction                  = "Inbound"
      #   access                     = "Allow"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "80"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      # },
      # {
      #   name                       = "Allow_HTTPS"
      #   description                = "Allow_HTTPS"
      #   priority                   = 110
      #   direction                  = "Outbound"
      #   access                     = "Allow"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "443"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      #}
    ]
    "db" = [
      #{
      #   name                       = "Allow_PostgreSQL"
      #   description                = "Allow_PostgreSQL"
      #   priority                   = 115
      #   direction                  = "Inbound"
      #   access                     = "Allow"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "5432"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      #}
    ]
    "appgw" = [
      {
        name                       = "Allow_AppGW"
        description                = "Allow incoming internet traffic on ports 80 & 443 for the Application Gateway"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["80", "443"]
        source_address_prefix      = "*"
        destination_address_prefix = "10.0.32.0/24"
      },
      {
        name                       = "Allow_Infrastructure_Ports"
        description                = "Allow incoming requests from the source as the GatewayManager service tag and Any destination"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      }
    ]
    # "new" = [
    #   {
    #     name                       = "Allow_PostgreSQL"
    #     description                = "Allow_PostgreSQL"
    #     priority                   = 100
    #     direction                  = "Inbound"
    #     access                     = "Allow"
    #     protocol                   = "Tcp"
    #     source_port_range          = "*"
    #     destination_port_range     = "5432"
    #     source_address_prefix      = "*"
    #     destination_address_prefix = "*"
    #   }
    # ]
  }
}

# NAT Gateway module
locals {
  natgw_subnet_names = ["app", "db"]
}


# Static website module
locals {
  sites = {
    # "devstaticwebsite" = {
    #   storage_account_tier             = "Standard"
    #   storage_account_replication_type = "LRS"
    # }
    "teststaticwebsite" = {
      storage_account_tier             = "Standard"
      storage_account_replication_type = "LRS"
    }
  }
}

# CDN profile module
locals {
  # CDN endpoint module
  cdn_endpoints = {
    # dev-wavenet-cg-cdn-endpoint = {
    #   origin_name                          = "devstaticwebsite"
    #   cdn_endpoint_custom_domain_name      = "dev-cyberguard-wavenet-co-uk"
    #   cdn_endpoint_custom_domain_host_name = "dev.cyberguard.wavenet.co.uk"
    # }
    test-wavenet-cg-cdn-endpoint = {
      origin_name                          = "teststaticwebsite"
      cdn_endpoint_custom_domain_name      = "test-cyberguard-wavenet-co-uk"
      cdn_endpoint_custom_domain_host_name = "test.cyberguard.wavenet.co.uk"
    }
  }
}

# App Gateway module
locals {
  appgw_sku = {
    name = "Standard_v2"
    tier = "Standard_v2"
  }
  appgw_gateway_ip_configuration_name = "appgw-gateway-ip-configuration"
  appgw_gateway_ip_configuration      = {}
  appgw_subnet_name                   = "appgw"
  appgw_frontend_port_name            = "appgw-fe-port"
  appgw_frontend_port = {
    port = 80
  }
  appgw_frontend_ip_configuration_name = "appgw-fe-ip-configuration"
  appgw_frontend_ip_configuration      = {}
  appgw_backend_address_pool_name      = "appgw-backend-address-pool"
  appgw_backend_address_pool           = {}
  appgw_backend_http_settings_name     = "appgw-backend-http-settings"
  appgw_backend_http_settings = {
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }
  appgw_http_listener_name = "appgw-http-listener"
  appgw_http_listener = {
    protocol = "Http"
  }
  appgw_request_routing_rule_name = "appgw-request-routing-rule"
  appgw_request_routing_rule = {
    priority  = 10
    rule_type = "Basic"
  }
}

# AKS module
locals {
  default_node_pool_vnet_subnet_name = "app"
  service_cidr                       = "10.1.0.0/20"
  dns_service_ip                     = "10.1.0.10"
}

# ACR module

# Key Vault module

# DB module
locals {
  db_private_dns_zone_name   = "${var.environment}-db-private-dns-zone.postgres.database.azure.com"
  db_dns_zone_vnet_link_name = "${var.environment}-postgresql-dns-zone-vnet-link"
  delegated_subnet_id_name   = "db"
}
