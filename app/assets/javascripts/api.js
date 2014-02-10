function FQ() {
  this.api_response = {};
  var self = this;
}

this.my_log = function(str) {
  console.log(str);
}

this.set_results = function(data) {
  this.api_response = data;
}

this.set_api_response = function (data) {
  self.set_results(data);
}

FQ.prototype.post = function(url, data, cb_funct) {
  $.post(url,
         data,
         cb_funct,
         "json"
        )
        .done(cb_funct)
        .fail(cb_funct);
  return this;
}

FQ.prototype.get_results = function () {
    return this.api_response;
};

FQ.prototype.toString = function () {
    return '(' + this.getValue() + ')';
};

