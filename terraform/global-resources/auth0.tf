resource "auth0_rule" "allow-github-orgs" {
  name = "allow-github-orgs"
  script = file(
    "${path.module}/resources/auth0-rules/allow-github-orgs.js",
  )
  order   = 10
  enabled = true
}

resource "auth0_rule" "add-github-teams-to-oidc-group-claim" {
  name = "add-github-teams-to-oidc-group-claim"
  script = file(
    "${path.module}/resources/auth0-rules/add-github-teams-to-oidc-group-claim.js",
  )
  order   = 30
  enabled = true
}

resource "auth0_rule" "add-github-teams-to-saml-mappings" {
  name = "add-github-teams-to-saml-mappings"
  script = file(
    "${path.module}/resources/auth0-rules/add-github-teams-to-saml-mappings.js",
  )
  order   = 40
  enabled = true
}

resource "auth0_rule_config" "aws-account-id" {
  key   = "AWS_ACCOUNT_ID"
  value = data.aws_caller_identity.cloud-platform.account_id
}

resource "auth0_rule_config" "k8s-oidc-group-claim-domain" {
  key   = "K8S_OIDC_GROUP_CLAIM_DOMAIN"
  value = "https://k8s.integration.dsd.io/groups"
}

resource "auth0_rule_config" "aws-saml-provider-name" {
  key   = "AWS_SAML_PROVIDER_NAME"
  value = aws_iam_saml_provider.auth0.name
}

resource "auth0_rule_config" "aws-saml-role-prefix" {
  key   = "AWS_SAML_ROLE_PREFIX"
  value = "saml-github."
}

resource "auth0_client" "management" {
  name        = "management:actions"
  description = "Cloud Platform Actions"
  app_type    = "non_interactive"

  custom_login_page_on = true
  is_first_party       = true
  oidc_conformant      = true
  sso                  = true

  jwt_configuration {
    alg                 = "RS256"
    lifetime_in_seconds = "2592000"
  }
}

resource "auth0_client_grant" "management_grant" {
  client_id = auth0_client.my_client.id
  audience  = "https://moj-cloud-platforms-dev.eu.auth0.com/api/v2/"
  scope     = ["create:"]
}