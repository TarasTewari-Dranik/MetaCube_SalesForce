public with sharing class AccountsSearchController {

    public Account acc {get;set;}  
    public ApexPages.StandardSetController con{get; set;}
    
    public AccountsSearchController (){
       acc = new Account();
       lstAccount = new List<Account>();
    }
    public List<Account> lstAccount { 
        get{ 
            if(con != null) 
                return (List<Account>)con.getRecords(); 
            else 
                return null ; 
        } 
        set;
    } 

    public PageReference Search(){
        String query= '';
        String strFilter = '';
        if(acc.Name != null && (acc.Name).trim() !='') {
           strFilter = strFilter  +  ' where Name Like \''+acc.Name+'%\'' ;
        }
        if(acc.BillingCity != null && (acc.BillingCity).trim() !='' ){
           if(strFilter == ''){
               strFilter = strFilter  +  ' where BillingCity like \''+acc.BillingCity+'%\'' ;
           }
           else
           {
               strFilter = strFilter  +  ' And BillingCity like \''+acc.BillingCity+'%\'' ;
           }
        }
        if(acc.BillingState != null && (acc.BillingState).trim() !='' ){
           if(strFilter == ''){
               strFilter = strFilter  +  ' where BillingState like \''+acc.BillingState+'%\'' ;
           }
           else
           {
               strFilter = strFilter  +  ' And BillingState like \''+acc.BillingState+'%\'' ;
           }
        }
        if(acc.BillingCountry != null && (acc.BillingCountry).trim() !='' ){
           if(strFilter == ''){
               strFilter = strFilter  +  ' where BillingCountry like \''+acc.BillingCountry+'%\'' ;
           }
           else
           {
               strFilter = strFilter  +  ' And BillingCountry like \''+acc.BillingCountry+'%\'' ;
           }
        }
        if(strFilter != '')
        {
            query = 'SELECT Id,Name,BillingCity,BillingState,BillingCountry From Account'+strFilter+ ' limit 10000';
            System.debug('Query ---->'+ query );
            con = new ApexPages.StandardSetController(Database.getQueryLocator(query));
            con.setPageSize(10);
        }else {
            con = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Name,BillingCity,BillingState,BillingCountry From Account]));
            con.setPageSize(10);
        }
       return null;
    }

    public Boolean hasNext 
    { 
        get 
        { 
            return con.getHasNext(); 
        } 
        set; 
    } 

    public Boolean hasPrevious 
    { 
        get 
        { 
            return con.getHasPrevious(); 
        } 
        set; 
    } 

    public Integer pageNumber 
    { 
        get 
        { 
            return con.getPageNumber(); 
        } 
        set; 
    } 
    
    public void first() 
    { 
        con.first(); 
    } 

    public void previous() 
    { 
        con.previous(); 
    } 

    public void next() 
    { 
        con.next(); 
    }
    
    public void last() 
    { 
        con.last(); 
    } 
}