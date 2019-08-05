#https://registry.terraform.io/modules/hashicorp/vault/aws/0.13.1

module "vault" {
  source = "hashicorp/vault/aws"
  version = "0.13.1"
  ami_id = ""
  hosted_zone_domain_name = ""
  ssh_key_name = ""
  vault_domain_name = ""
  #consul_cluster_name
  #consul_cluster_size
  #consul_cluster_tag_key
  #consul_instance_type
  #create_dns_entry
  #subnet_tags
  #use_default_vpc
  #vault_cluster_name
  #vault_cluster_size
  #vault_instance_type
  #vpc_tags
}
