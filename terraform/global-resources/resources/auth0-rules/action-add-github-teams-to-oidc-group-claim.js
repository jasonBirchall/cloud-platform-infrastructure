
exports.onExecutePostLogin = async (event, api) => {
    var _ = require('lodash');
    const namespace = 'https://k8s.integration.dsd.io/groups';
  
    // Apply to 'github' connections only
    if(event.connection.strategy === 'github'){
  
      const { MGMT_DOMAIN, MGMT_ID, MGMT_SECRET } = event.secrets;
      
    const axios = require("axios");
  
    const url = 'https://moj-cloud-platforms-dev.eu.auth0.com/oauth/token';
  
      var data = {
          grant_type: 'client_credentials',
          client_id: MGMT_ID,
          client_secret: MGMT_SECRET,
          audience: 'https://moj-cloud-platforms-dev.eu.auth0.com/api/v2/',
        };
  
  // TODO error handling
      const mgmt_response = await axios.post(url,data)
  
      const headers = {
          'Authorization': 'Bearer '+mgmt_response.data.access_token,
          'content-type': 'application/json'
      };
      const idp_url = 'https://moj-cloud-platforms-dev.eu.auth0.com/api/v2/users/'+event.user.user_id
      // TODO error handling
      const idp_response = await axios.get(idp_url, { headers })
  
  
      var github_identity = _.find(idp_response.data.identities,{ connection: 'github' })
   
      // Get list of user's Github teams
     
     // TODO error handling
      const users_response = await axios.get(`https://api.github.com/user/teams`, {
      headers: {
        'Authorization': "token " + github_identity.access_token
      }
      });
  
      var teams = users_response.data
  
      var git_teams = [];
  
      _.forEach(teams, function(team, i) { 
          if (team.organization.login === "ministryofjustice") {
            git_teams.push("github:" + team.slug);
          }
      });
         
      api.idToken.setCustomClaim(`${namespace}`, git_teams);
  
      return;
  
    } else {
      return;
    }
  };
