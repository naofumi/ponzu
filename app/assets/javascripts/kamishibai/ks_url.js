window.KSUrl = function(){
	var self = this;

	// Strips the protocol, host and port
	// from the url string. Uses the current
	// protocol, host and port.
	// TODO: toNormalizedPath actually does a stripHost
	//       so we probably don't need stripHost.
	function stripHost(url) {
		return toNormalizedPath(url.replace(/^https?:\/\/[^/]+/, ''));
	}

	// Use this function to convert trailing slashes
	// into Rails style.
	function toNormalizedPath(url) {
	  // Remove domain from href
	  url = url.replace(/^https?:\/\/[^\/]+/, '');
	  // remove trailing "/" to equate to rails paths
	  // unless root (always have a "/" for root).
	  if (url.length == 0) {
	    url += "/";
	  } else {
	    url = url.replace(/([^\/]+)\/+$/, "$1");
	  }
	  return url;
	}

	// Takes the whole Href (kamishibai style href with hash) 
	// in the location bar and returns information.
	function parseHref(href) {
	  if (href.indexOf('#!') == -1) return false;
	  var hashPos = href.indexOf('#');
	  var baseUrl = toNormalizedPath(href.slice(0, hashPos));
	  var hash = href.slice(hashPos + 1);
	  var resourceUrl = null, pageId = null;
	  if (/^!_/.exec(hash)) {
	    var separatorPos = hash.indexOf('__');
	    if (separatorPos != -1) {
	      resourceUrl = hash.slice(2, separatorPos);
	      pageId = hash.slice(separatorPos + 2);
	    } else {
	      resourceUrl = hash.slice(2);
	    }
	  } else {
	    pageId = hash.slice(1);
	  }
	  if (resourceUrl) resourceUrl = toNormalizedPath(resourceUrl);
	  return {baseUrl: baseUrl, resourceUrl: resourceUrl, pageId: pageId};
	}

	return {
		toNormalizedPath: toNormalizedPath,
		parseHref: parseHref,
		stripHost: stripHost
	}
}();