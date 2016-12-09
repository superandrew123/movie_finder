MovieFinder = {
  init: function(){

  },
  readInput: function(){
    var search_text = this.value;
    if(search_text.length > 2){
      MovieFinder.search(search_text);
    }
  },
  search: function(search_term){
    $.ajax({
      method: 'get', 
      dataType: 'json', 
      url: 'http://localhost:3000/search',
      data: {
        q: search_term
      },
      success: function(data){
        debugger;
      }
    });
  }
}