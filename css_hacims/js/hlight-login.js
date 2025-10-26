function highlight() { 
var elements = document.getElementsByTagName("input");
  for (i=0; i < elements.length; i++) { 

     if(elements[i].getAttribute('type')=="text") { 
       elements[i].onfocus=function() {

		this.className='input_txt_login_hover';
       }; 
       elements[i].onblur=function() {

         this.className='input_txt_login';
      }; 


	 
    } 




	
  } 
} 

window.onload = highlight;
