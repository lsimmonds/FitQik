function PostFQ() { //A class
  alert("load Post");

  /**
   * Perform a form post.
   *
   * Create a form and an iframe, and perform a post to the iframe.
   *
   * The complete function is called when the iframe the form is posting to is loaded;
   * in short, the load event is triggered.  This function will be called even if the
   * iframe loads a 404 page.
   *
   * The success function is called when the iframe sends a message via postMessage()
   * to the parent window, and the message is accepted by the handler.  The message must
   * be a JSON string with the following format: {id: "", data: {}}.  The id value is the
   * value passed in the form field "rl_eid".
   *
   * .post(uri, data, options)
   * uri - string - URL where request is sent
   * data - object - key-value mapping
   * options - object - (optional) key-value mapping
   *
   * options object:
   * id - string - form ID
   * complete - function - function to be called when the request finishes
   * success - function - function to be called if the request succeeds
   *
   * success function:
   * - object - data returned from post destination
   */

  this.post = function(url, data, options) {
console.log("in post url: "+url+", data: "+JSON.stringify(data)+", options: "+JSON.stringify(options));
      var iframeEId,
          formEId,
          rootE,
          iframeE,
          formE;

console.log("in post some more");
      if (typeof url !== "string" || !url) {
        // Endpoint url must be valid.
        return false;
      }

      if (!$.isPlainObject(options)) {
        options = {};
      }
      if (typeof options.id !== "string" || !options.id) {
        options.id = String.random(10);
      }

      iframeEId = ["iframefq", options.id].join("-");
      formEId = ["formfq", options.id].join("-");

      // Create a hidden div.
      rootE = this.createRoot();

      // Create an iframe element node.
      iframeE = this.createIframe({
        id: iframeEId,
        name: iframeEId.replace(/-/g, "_"),
        parentNode: rootE,
        complete: {
          handler: this._iframeLoadHandler,
          data: {
            success: options.success,
            complete: options.complete,
            nodesToRemove: [iframeEId, formEId]
          }
        }
      });

      // Create form element node.
      formE = this.createForm({
        id: formEId,
        method: "post",
        action: url,
        target: iframeE.name,
        parentNode: rootE,
        data: data
      });

      if (typeof options.success === "function") {
        this.WindowMessageListener.bind(this._iframeWindowMessageHandler, options.id, {success: options.success, nodesToRemove: [iframeEId, formEId]});
      }

console.log("formE: "+JSON.stringify(formE));
      $(formE).submit();
  };

    /**
     * Remove element nodes asynchronously.
     *
     * Remove an array of element nodes asynchronously.
     *
     * Node.remove(nodes, delay)
     * nodes - array - array of element nodes
     * delay - int - a number greater than 0 (in milliseconds)
     */
    this.remove = function(nodes, delay) {
      if (!$.isArray(nodes)) {
        nodes = [];
      }
      if (!delay || delay < 1) {
        delay = 1;
      }

      var removeNodesFn = function() {
        $(nodes).remove();
      };

      setTimeout(removeNodesFn, delay);
    };

    /**
     * Remove nodes from DOM.
     *
     * .post._removeNodes(nodes)
     * nodes - array - array of node ids to remove
     */
    this._removeNodes = function(nodeIds) {
      var nodes,
          node;

      if (!$.isArray(nodeIds)) {
        return false;
      }

      nodes = [];

      for (var i = 0, length = nodeIds.length; i < length; i++) {
        // Get element node and cache it in an array.
        if (node = document.getElementById(nodeIds[i])) {
          nodes.push(node);
        }
      }

      RL_LIB.Node.remove(nodes, 100);
    };

    /**
     * Remove nodes and execute success callback function when the iframe content loaded and executed.
     *
     * .post._iframeWindowMessageHandler(wmlData, data, origin)
     * wmlData - object - hash of data
     * data - object - hash of data
     * origin - string - iframe content url
     */
    this._iframeWindowMessageHandler = function(wmlData, data, origin) {
      // Remove bound event since it should never be used again.
      this.WindowMessageListener.unbind(wmlData.WML_EVENT_ID);

      // Clean up nodes from DOM.
      this._removeNodes(wmlData.nodesToRemove);

      // Return data to success function.
      wmlData.success(data);
    };

      /**
     * Create a simple FORM element node.
     *
     * Create a FORM element node with no submit button child element node.  If the settings.data is set,
     * hidden INPUT element node(s) are created and appended to the FORM element node.
     *
     * The settings.method param is defaulted to "post" if it is not set or set to an invalid value.
     *
     * The settings.data param allows for string, number, null, and array of string, number, and null values.
     * Ex. {foo: "bar", sky: 1, earth: null, water: ["foo", 1, null]}
     *
     * Node.createForm(settings)
     * settings - object - (optional) key-value mapping
     *
     * settings object:
     * id - string - element id
     * method - string - HTTP method ("get" or "post")
     * action - string - destination address of where to send the data
     * target - string - where to display the response
     * parentNode - object - parent node to attach to
     * data - object - key-value mapping
     *
     * Return: FORM element node.
     */
    this.createForm = function(settings) {
      var formE = document.createElement("form"),
          docFrag = document.createDocumentFragment();
console.log("createForm settings: "+JSON.stringify(settings));
      // Initialize settings param.
      settings = $.isPlainObject(settings) ? settings : JSON.parse(settings);

      if (typeof settings.id === "string" && settings.id !== "") {
        formE.id = settings.id;
      }
      if (typeof settings.action === "string" && settings.action !== "") {
        formE.action = settings.action;
      }
      if (typeof settings.target === "string" && settings.target !== "") {
        formE.target = settings.target;
      }
      formE.method = typeof settings.method === "string" && settings.method === "get" ? "get" : "post";

console.log("settings.data: "+JSON.stringify(JSON.parse(settings.data)));
      if ($.isPlainObject(JSON.parse(settings.data))) {
        // Create FORM INPUT element nodes.
da_data=JSON.parse(settings.data).api_user;
console.log("PlainObject");
        for (var key in da_data) {
          var value = da_data[key];
console.log("key: "+key+", value: "+value);

          if (typeof value === "string" || typeof value === "number" || value === null) {
console.log("before docFrag: "+docFrag.textContent+", nodeName: "+docFrag.nodeName+", nodeType: "+docFrag.nodeType+", nodeValue: "+docFrag.nodeValue+", childNodes.textContent: "+typeof docFrag.childNodes);
            docFrag.appendChild($("<input>", {name: key, value: value, type: "hidden"}).get(0));
console.log("str: "+$("<input>", {name: key, value: value, type: "hidden"}).get(0));
console.log("after docFrag: "+docFrag.textContent+", nodeName: "+docFrag.nodeName+", nodeType: "+docFrag.nodeType+", nodeValue: "+docFrag.nodeValue+", childNodes.textContent: "+docFrag.childNodes.innerHTML);
          } else if ($.type(value) === "array") {
console.log("array");
            var keyArrayName = [key, "[]"].join("");
            for (var i = value.length; --i >= 0;) {
              // Create an INPUT element node for each value array element.
              var valueArrayElement = value[i];
              if (typeof valueArrayElement === "string" || typeof valueArrayElement === "number" || valueArrayElement === null) {
                docFrag.appendChild($("<input>", {name: keyArrayName, value: valueArrayElement, type: "hidden"}).get(0));
              }
            }
          }
          else {
console.log("$.type(value): "+$.type(value));
          }
        }
console.log("docFrag: "+docFrag.textContent);
        if (docFrag.hasChildNodes()) {
          formE.appendChild(docFrag);
        }
      }

      if (typeof settings.parentNode === "object" && settings.parentNode.nodeType === 1) {
        settings.parentNode.appendChild(formE);
      }

console.log("FormE: "+JSON.stringify(formE));
      return formE;
    };

    /**
     * Create a simple IFRAME element node.
     *
     * The settings.complete can be a function or a key-value map that contains the handler function and a data key-value map.
     *
     * If settings.complete is a function, then that is executed when the iframe "load" event is triggered.  The event object
     * is passed to settings.complete as the 1st argument.
     *
     * If settings.complete is a key-value map and settings.complete.handler is a function, it is executed when
     * the iframe "load" event is triggered.  If settings.complete.data is a key-value map, then that is passed to
     * settings.complete.handler as the 2nd argument.  The 1st argument is the event object.
     *
     * For both settings.complete and settings.complete.handler functions, "this" is set as the IFRAME element node.
     *
     * Node.createIframe(settings)
     * settings - object - (optional) key-value mapping
     *
     * settings object:
     * id - string - (optional) element id
     * complete - function/object - (optional) load event handler or key-value map that contains the load event handler and data
     * name - string - (optional) element name
     * parentNode - object - (optional) parent node to attach to
     * src - string - (optional) address of the document to embed
     *
     * complete object:
     * handler - function - the handler to execute
     * data - object - (optional) key-value map passed to the handler
     *
     * complete/handler function:
     * object - the event object
     * object - settings.complete.data
     *
     * Return: IFRAME element node.
     */
    this.createIframe = function(settings) {
        var $iframeE,
            completeHandler,
            completeData;
console.log("this.createIframe settings: "+JSON.stringify(settings));

        // Initialize settings param.
        settings = $.isPlainObject(settings) ? settings : {};
        if (typeof settings.complete === "function") {
          completeHandler = settings.complete;
        } else if ($.isPlainObject(settings.complete)) {
          if (typeof settings.complete.handler === "function") {
            completeHandler = settings.complete.handler;
          }
          if ($.isPlainObject(settings.complete.data)) {
            completeData = settings.complete.data;
          }
        }
        if (typeof settings.id !== "string") {
          settings.id = "";
        }
        if (typeof settings.name !== "string") {
          settings.name = "";
        }
        if (typeof settings.src !== "string" || settings.src.length < 1) {
          settings.src = "about:blank";
        }

        $iframeE = $("<iframe>").prop({
            id: settings.id,
            name: settings.name,
            src: settings.src
          });

        if (typeof settings.parentNode === "object" && settings.parentNode.nodeType === 1) {
          $iframeE.appendTo(settings.parentNode);
        }

        if (completeHandler) {
          $iframeE.on("load", {complete: completeHandler, data: completeData}, this._iframeLoadHandler);
        }

        return $iframeE.get(0);
    };

    /**
     * this._iframeLoadHandler($event)
     */
    this._iframeLoadHandler = function(event) {
      event.data.complete.call(this, event.originalEvent, event.data.data);
    };


  this.createRoot = function() {
      var $rootE = $("#rootfq");

console.log("in createRoot");
      if ($rootE.length === 0) {
        // Create .
        $rootE = $("<div>", {id: "rootfq", css: {left: "-9999px", top: "-9999px", display: "none", property: "absolute"}}).appendTo($("body"));
      }

      return $rootE.get(0);
  };

  
  this.WindowMessageListener = function() {
    /**
     * Will automatically listen to "message" events triggered by postMessage() calls.
     * See https://developer.mozilla.org/en-US/docs/DOM/window.postMessage.
     *
     * All RL postMessage() calls must pass a JSON string for the "message" parameter.
     * The string must contain "id" and "data" keys.  The "id" key maps to a string, and the "data" key
     * maps to an object.
     * Ex. "{\"id\":\"234234\",\"data\":{\"foo\":\"bar\"}}"
     */
    var queue = {},
        unbindCounter = 0,    // Number of unbind() calls.
        API;

    API = {
      /**
       * Attach a handler to the "message" event for the window DOM object.
       *
       * If binding is success, return an unique id (user-specified id) or else the boolean false.
       *
       * When the handler is triggered, the returned-id is passed as data.WML_EVENT_ID.
       *
       * WindowMessageListener.bind(handler, data)
       * handler - function - function to execute each time the event is triggered
       * id - string - (optional) user-defined id
       * data - object - (optional) key-value mapping containing data that will be passed to the event handler
       *
       * handler function parameters:
       * object - (optional) data object from .bind()
       * object - (optional) data sent by the document that caused the event
       * string - (optional) the scheme, hostname and port of the document that caused the event
       *
       * Return: string/boolean
       */
      bind: function(handler, id, data) {
        var id;

        if (typeof handler !== "function") {
          return false;
        }

        if (typeof id !== "string" || id.length < 1) {
          id = String.random(10);
        }
        data = $.isPlainObject(data) ? $.extend({}, data) : {};
        data.WML_EVENT_ID = id;   // Make event id available to the handler.

        queue[id] = {
          handler: handler,
          data: $.isPlainObject(data) ? $.extend({}, data) : undefined
        };

        return id;
      },

      /**
       * Parse JSON string message sent by postMessage() call.
       *
       * Parse "id" and "data" key values, and return them along with the event origin value in
       * a key-value mapping object.  If those keys do not exist or the "id" key value is not a valid
       * string, then return the boolean false
       *
       * WindowMessageListener.parseEvent(event)
       * event - object - DOM event object
       *
       * Return: object
       */
      parseEvent: function(event) {
        var id,
            data,
            payload;

        if (!event) {
          return false;
        }

        try {
          payload = JSON.parse(event.data);
        } catch(err) {
          // Not a valid message.
          return false;
        }

        if ($.isPlainObject(payload)) {
          id = payload.id;
          data = payload.data;
        }

        if (typeof id !== "string" || id.length === 0) {
          // Invalid id.
          return false;
        }

        return {
          id: id,
          data: data,
          origin: event.origin
        }
      },

      /**
       * Return a copy of the queue.
       *
       * WindowMessageListener.queue()
       *
       * Return: object
       */
      queue: function() {
        return $.extend(true, {}, queue);
      },

      /**
       * Execute handler.
       *
       * If id maps to a handler, then execute the handler and return true or else return false.
       *
       * WindowMessageListener.trigger(id, data, origin)
       * id - string - unique id returned by .bind()
       * data - object - (optional) any object.
       * origin - string - (optional) the scheme, hostname and port
       *
       * Return: boolean
       */
      trigger: function(id, data, origin) {
        var wmlEvent = typeof id === "string" ? queue[id] : undefined;

        if (wmlEvent === undefined) {
          return false;
        }

        wmlEvent.handler(wmlEvent.data, data, origin);

        return true;
      },

      /**
       * Remove a previously-attached event handler for the window DOM object.
       *
       * If id maps to a handler, remove handler and return id or else return the boolean false.
       * After 10 successful unbind() calls, the queue object is cleaned up by removing keys that map to
       * the "undefined" object.
       *
       * If id is undefined, remove all handlers.
       *
       * WindowMessageListener.unbind(id)
       * id - string - (optional) unique id returned by .bind()
       *
       * Return: string/boolean
       */
      unbind: function(id) {
        if (id === undefined) {
          // Remove all handlers.
          queue = {};
          unbindCounter = 0;

          return true;
        } else if (typeof id === "string" && queue[id]) {
          // Remove mapped handler.
          queue[id] = undefined;

          if (++unbindCounter > 2) {
            // Clean up queue object.
            queue = this.queue();
            unbindCounter = 0;
          }

          return id;
        }

        return false;
      }
    };


    if (window.jasmine && window.jasmine.SnapdragonConsoleReporter) {
      // Need for Jasmine tests.
      API.setQueue = function(newQueue) {
        queue = newQueue;
      };
      API.getQueue = function() {
        return queue;
      };
    }

    // Event handler for the "message" event.
    var eventHandlerFn = function($event) {
      var eventData = API.parseEvent($event.originalEvent);

      if (eventData === false) {
        // Not a valid RL message event.
        return;
      }

      API.trigger(eventData.id, eventData.data, eventData.origin);
    };

    // Bind event handler to "message" event.
    $(window).on("message", eventHandlerFn);

    return API;
  };

}
