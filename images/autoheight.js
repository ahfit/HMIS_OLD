

function calcHeight()
{

  var the_height=
    document.getElementById('holder').contentWindow.
      document.body.scrollHeight;


  document.getElementById('holder').height=
      the_height;
}
