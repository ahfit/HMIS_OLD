// JavaScript Document
function highlight() { 
var elements = document.getElementsByTagName("input");
  for (i=0; i < elements.length; i++) { 

     if(elements[i].getAttribute('type')=="text") { 
       elements[i].onfocus=function() {
     <!---->    this.style.borderColor='#5789C6'---#fffacc; 
         this.style.backgroundColor='#f7f4b4';
       }; 
       elements[i].onblur=function() {
   <!---->         this.style.borderColor='#AABBCC'; 
         this.style.backgroundColor='';
      }; 
    } 
  } 
} 

window.onload = highlight;
