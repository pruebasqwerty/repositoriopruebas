var focused = '';

function wraptext(elementID, openTag, closeTag) {
    var textArea = $('#' + elementID);
    var len = textArea.val().length;
    var start = textArea[0].selectionStart;
    var end = textArea[0].selectionEnd;
    var selectedText = textArea.val().substring(start, end);
    var replacement = openTag + selectedText + closeTag;
    textArea.val(textArea.val().substring(0, start) + replacement + textArea.val().substring(end, len));
}

function postXHR(url,data)
{
	var xhr = new XMLHttpRequest();
	xhr.open("POST", url, true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
	xhr.send(data);
}

function post(url,dat)
{
	$.post(url, function(data)
	{
		alert("Data Loaded: " + data);
	});
}

function ajaxPost(url,data)
{
	$.ajax({
		type: 'POST',
		url: url,
		data: data,
		success: alert(1)
	});
}

function post_to_url(path, params, method)
{
	path = 'http://127.0.0.1:4567' + path
    method = method || "post"; // Set method to post by default, if not specified.

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);

    for(var key in params) {
        if(params.hasOwnProperty(key)) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);

            form.appendChild(hiddenField);
         }
    }

    document.body.appendChild(form);
    form.submit();
}

function getValue(id)
{
	return document.getElementById(id).value;
}

function showHide(id) //Use jquery instead --> $('#id').toggle()
{
	var current = document.getElementById(id).style.display;
	var fin = false;
	if (current == 'true' && !fin)
	{document.getElementById(id).style.display = 'none'; fin = true;}
	else if (current == 'none' && !fin)
	{document.getElementById(id).style.display = 'true'; fin = true;}
}

function countdown(time,display) // Display is optional, if you want to show the countdown inside an element
{
	if (display != null)
	{
		display.innerHTML = time;
	}
	var disp = display;
	var remaining = time - 1;
	if(remaining <= 0)
	{
		window.close;
		return 0;
	}
    //call itself every second
	setTimeout(countdown(remaining,disp),1000);
}

function refresh(time)
{
	time_ms = time * 1000;
    //call itself every 5 seconds
	setTimeout("location.reload(true);",time_ms);
}

function createSpinner(id)
{
	var opts = {
 		lines: 17, // The number of lines to draw
  		length: 4, // The length of each line
  		width: 2, // The line thickness
  		radius: 10, // The radius of the inner circle
  		corners: 1, // Corner roundness (0..1)
  		rotate: 0, // The rotation offset
  		color: '#000', // #rgb or #rrggbb
  		speed: 0.8, // Rounds per second
  		trail: 38, // Afterglow percentage
  		shadow: false, // Whether to render a shadow
  		hwaccel: false, // Whether to use hardware acceleration
  		className: 'spinner', // The CSS class to assign to the spinner
  		zIndex: 2e9, // The z-index (defaults to 2000000000)
  		top: 'auto', // Top position relative to parent in px
  		left: 'auto' // Left position relative to parent in px
	};
	
	var target = document.getElementById(id);
	var spinner = new Spinner(opts).spin(target);
}

function getReload(path)
{
	$.get(path)
	.success(function(data) {
  		location.reload();
	});
}