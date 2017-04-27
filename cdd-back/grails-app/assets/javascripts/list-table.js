// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require bootstrap-table
//= require_self


function triggerRowSelection() {
	window.setTimeout(function() {
		selectedDatas.length = 0;
		$("#list").find("tr.selected").find("input").each(function(index, obj) {
			selectedDatas.push($(obj).val());
		});
	}, 10);
}
