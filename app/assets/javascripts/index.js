var templates = {};
var views = [];

navigator.geolocation.getCurrentPosition( function(geoposition){

   var latitude = geoposition.coords.latitude;
   var longitude = geoposition.coords.longitude;
   $("#longInput").val(longitude);
   $("#latInput").val(latitude);

});

var getTemplates = function(){

  var railsString = $("#rails-template").text()
  templates.railsInfo = Handlebars.compile(railsString);

  var busString = $("#bus-template").text()
  templates.busInfo = Handlebars.compile(busString);

  var bikeString = $("#bike-template").text()
  templates.bikeInfo = Handlebars.compile(bikeString);

};

var MetroStation = Backbone.Model.extend({

    defaults: {
    name: "",
    location: "",
    lines: ""
  	},

  viewDetails: function() {
    var details = this.toJSON();
    return details;
  }

});

var BusStop = Backbone.Model.extend({

    defaults: {
    name: "",
    location: "",
    lines: ""
  	},

  viewDetails: function() {
    var details = this.toJSON();
    return details;
  }

});

var BikeStation = Backbone.Model.extend({

    defaults: {
    name: "",
    bikes: 0,
    empty: 0,
  	},

  viewDetails: function() {
    var details = this.toJSON();
    return details;
  }

});

var MetroView = Backbone.View.extend({

  events: { "click .favorite": "markAsFavorite"},

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.railsInfo(this.model.viewDetails()));
  },

  markAsFavorite: function() {

  }

});

var BusView = Backbone.View.extend({

  events: { "click .favorite": "markAsFavorite"},

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.busInfo(this.model.viewDetails()));
  },

  markAsFavorite: function() {
  	
  }

});

var BikeView = Backbone.View.extend({

  events: { "click .favorite": "markAsFavorite"},

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.bikeInfo(this.model.viewDetails()));
  },

  markAsFavorite: function() {
  	
  }

});

/*var getRailResults = function(callback) {
    $.ajax({
      url: metro,
      method: "GET",
      success: function(data) {
        callback(data);
      }
    })
}

var displayRailResults = function(data) {

	_.each(data, function(element){
		element = new MetroStation;
		views.push(new MetroView(element));
	});

    _.each(views, function(element, index){
    $("#rails").append(views[index].el);
    });
}

var getBusResults = function(callback) {
    $.ajax({
      url: bus,
      method: "GET",
      success: function(data) {
        callback(data);
      }
    })
}

var displayBusResults = function(data) {

	_.each(data, function(element){
		element = new BusStop;
		views.push(new BusView(element));
	});

    _.each(views, function(element, index){
    $("#bus").append(views[index].el);
    });
}*/

var getBikeResults = function(callback) {
    $.ajax({
      url: "/dashboard/bikes.json",
      method: "GET",
      success: function(data) {
        callback(data);
      }
    })
}

var displayBikeResults = function(data) {

	_.each(data, function(element){
		element = new BikeStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty
		});
		views.push(new BikeView(element));
	});

    _.each(views, function(element, index){
    $("#bike").append(views[index].el);
    });
}


$(document).ready(function(){

	getTemplates();

	$("#search").click(function(){
	$("#resultsWrap").show();
	//getRailResults(displayRailResults);
	//getBusResults(displayBusResults);
	getBikeResults(displayBikeResults);
	});

});


