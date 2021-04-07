class Domain {

  String domain = "http://surveyqu.com/sqws/sqmid/index.php/";
  String client = 'surveyqu';
  String auth = 'svq1234';

  String getDomain(){
    return domain;
  }

  String getHeaderClient(){
    return client;
  }
  String getHeaderAuth(){
    return auth;
  }

}