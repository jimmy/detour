detour = function() {
  var notify = function(message) {
    var notice = $("<p>" + message + "</p>");
    notice
      .css("text-align", "center")
      .css("background-color", "#ff0");

    notice
      .hide()
      .appendTo($('#notice'))
      .fadeIn(300)
      .delay(600)
      .fadeOut(300, function(){notice.remove()});
  };

  var render_dispatcher = function(display_notice) {
    $('#map').val(localStorage.map);
    if (display_notice) {
      notify("saved");
    }
  }

  var submit_handler = function() {
    try {
      var map = JSON.parse($('#map').val());
      localStorage.map = $('#map').val();
      render_dispatcher(true);
    } catch (e) {
      notify(e.message)
    }

    return false;
  };

  var init = function() {
    try {
      var pathname = window.location.pathname.replace(/^\//, '');
      var map = JSON.parse(localStorage.map);
      var target = map[pathname];
    } catch (e) {
      notify(e.message)
    }

    if (target) {
      window.location.replace(target);
    } else {
      $('#form').submit(submit_handler);
      render_dispatcher();
      $('#content').show();
    }
  };

  return {
    init: init
  };
}();
