//-- Adapted to work with the getUserMedia API using code from http://wesbos.com/html5-video-face-detection-canvas-javascript/ -->

// Image data from local image
var imageObj = document.createElement('img');
imageObj.src = "webcam.jpg";

// Store the annotations
var annotationObjects = new Array();
var annotationMode = "line";

// requestAnimationFrame shim
(function () {
    var i = 0,
        lastTime = 0,
        vendors = ['ms', 'moz', 'webkit', 'o'];

    while (i < vendors.length && !window.requestAnimationFrame) {
        window.requestAnimationFrame = window[vendors[i] + 'RequestAnimationFrame'];
        i++;
    }

    if (!window.requestAnimationFrame) {
        window.requestAnimationFrame = function (callback, element) {
            var currTime = new Date().getTime(),
                timeToCall = Math.max(0, 1000 / 60 - currTime + lastTime),
                id = setTimeout(function () { callback(currTime + timeToCall); }, timeToCall);

            lastTime = currTime + timeToCall;
            return id;
        };
    }
}());

var App = {
    start: function (stream) {
        App.video.addEventListener('canplay', function () {
            App.video.removeEventListener('canplay');
            setTimeout(function () {
                App.video.play();
                App.canvas.style.display = 'inline';
                App.info.style.display = 'none';
                App.canvas.width = App.video.videoWidth;
                App.canvas.height = App.video.videoHeight;
                App.backCanvas.width = App.video.videoWidth / 4;
                App.backCanvas.height = App.video.videoHeight / 4;
                App.backContext = App.backCanvas.getContext('2d');

                App.drawToCanvas();
            }, 500);
        }, true);

        var domURL = window.URL || window.webkitURL;
        App.video.src = domURL ? domURL.createObjectURL(stream) : stream;
    },
    denied: function () {
        App.info.innerHTML = 'Camera access denied!<br>Please reload and try again.';
    },
    error: function (e) {
        if (e) {
            console.error(e);
        }
        App.info.innerHTML = 'Please go to about:flags in Google Chrome and enable the &quot;MediaStream&quot; flag.';
    },
    drawToCanvas: function () {
        requestAnimationFrame(App.drawToCanvas);

        var video = App.video,
            ctx = App.context,
            backCtx = App.backContext;

        ctx.drawImage(video, 0, 0, App.canvas.width, App.canvas.height);

        DrawAnnotations(ctx);
        //backCtx.drawImage(video, 0, 0, App.backCanvas.width, App.backCanvas.height);
    }
};

App.init = function () {
    App.video = document.createElement('video');
    App.backCanvas = document.createElement('canvas');
    App.canvas = document.querySelector('#output');
    App.canvas.style.display = 'none';
    App.context = App.canvas.getContext('2d');
    App.info = document.querySelector('#info');

    navigator.getUserMedia_ = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
    
    try {
        navigator.getUserMedia_({
            video: true,
            audio: false
        }, App.start, App.denied);
    } catch (e) {
        try {
            navigator.getUserMedia_('video', App.start, App.denied);
        } catch (e) {
            App.error(e);
        }
    }

    App.video.loop = App.video.muted = true;
    App.video.load();
};

App.init();

function btnCapture() {
    var img = App.canvas.toDataURL("image/png");
    window.open(img, "_blank", "menubar=0,titlebar=0,toolbar=0,width=228,height=272");
	
}

function btnPlayPause() {
    if (App.video.paused)
        App.video.play();
    else
        App.video.pause();
}

function DrawAnnotations(ctx) {
    if (annotationObjects.length > 0) {
        annotationObjects.forEach(function (obj) {
            obj.draw(ctx);
        });
    }
}

function LineObj() {
    this.width = 1;
    this.lineCap = "butt"; //butt,round,square
    this.startX = 0;
    this.startY = 0;
    this.endX = 10;
    this.endY = 10;
    this.lineJoin = "miter"; //miter,round,bevel
    this.strokeStyle = "#FF0000";

    this.draw = function (ctx) {
        ctx.beginPath();
        ctx.lineWidth = this.width;
        ctx.lineCap = this.lineCap;
        ctx.lineJoin = this.lineJoin;
        ctx.strokeStyle = this.strokeStyle;
        ctx.moveTo(this.startX, this.startY);
        ctx.lineTo(this.endX, this.endY);
        ctx.stroke();
    };
}

function RectObj() {
    this.lineWidth = 1;
    this.x = 0;
    this.y = 0;
    this.width = 10;
    this.height = 10;
    this.strokeStyle = "#FF0000";
    this.ifFill = false;
    this.fillStyle = "#FF0000";

    this.draw = function (ctx) {
        ctx.lineWidth = this.lineWidth;
        ctx.strokeStyle = this.strokeStyle;
        ctx.fillStyle = this.fillStyle;
        if (this.ifFill)
            ctx.fillRect(this.x, this.y, this.width, this.height);
        else
            ctx.rect(this.x, this.y, this.width, this.height);
        ctx.stroke();
    }
}

function TextObj() {
    this.lineWidth = 1;
    this.font = "10px sans-serif";
    this.textAlign = "left";   //start,end,center,left,right
    this.ifFill = false;
    this.strokeStyle = "#FF0000";
    this.fillStyle = "#FF0000";
    this.x = 0;
    this.y = 0;
    this.text = "Hello World";

    this.draw = function (ctx) {
        ctx.lineWidth = this.lineWidth;
        ctx.font = this.font;
        ctx.textAlign = this.textAlign;
        ctx.strokeStyle = this.strokeStyle;
        ctx.fillStyle = this.fillStyle;
        if (this.ifFill)
            ctx.fillText(this.text, this.x, this.y);
        else
            ctx.strokeText(this.text, this.x, this.y);
    }
}

function ArcObj() {
    this.width = 1;
    this.radius = 10;
    this.x = 0;
    this.y = 0;
    this.startAngle = 0;
    this.endAngle = 2*Math.PI;
    this.strokeStyle = "#FF0000";

    this.draw = function (ctx) {
        ctx.beginPath();
        ctx.lineWidth = this.width;
        ctx.strokeStyle = this.strokeStyle;
        ctx.arc(this.x, this.y, this.radius, this.startAngle, this.endAngle);
        ctx.stroke();
    };
}

function ImgObj() {
    this.x = 0;
    this.y = 0;
    this.width = 100;
    this.height = 100;
    this.imageData = imageObj;

    this.draw = function (ctx) {
        ctx.drawImage(this.imageData, this.x, this.y,this.width,this.height);
    };
}

function radioClicked(obj) {
    document.getElementById("r_line").checked = obj.id == "r_line" ? true : false;
    document.getElementById("r_rect").checked = obj.id == "r_rect" ? true : false;
    document.getElementById("r_arc").checked = obj.id == "r_arc" ? true : false;
    document.getElementById("r_text").checked = obj.id == "r_text" ? true : false;
    document.getElementById("r_image").checked = obj.id == "r_image" ? true : false;

    document.getElementById("div_line").style.display = obj.id == "r_line" ? "inline" : "none";
    document.getElementById("div_rect").style.display = obj.id == "r_rect" ? "inline" : "none";
    document.getElementById("div_arc").style.display = obj.id == "r_arc" ? "inline" : "none";
    document.getElementById("div_text").style.display = obj.id == "r_text" ? "inline" : "none";
    document.getElementById("div_image").style.display = obj.id == "r_image" ? "inline" : "none";

    switch (obj.id) {
        case "r_line":
            annotationMode = "line";
            break;
        case "r_rect":
            annotationMode = "rect";
            break;
        case "r_arc":
            annotationMode = "arc";
            break;
        case "r_text":
            annotationMode = "text";
            break;
        case "r_image":
            annotationMode = "image";
            break;
    }
}

function addAnnotation() {
    switch (annotationMode) {
        case "line":
            var line = new LineObj();
            line.startX = document.getElementById("line_startX").value;
            line.startY = document.getElementById("line_startY").value;
            line.endX = document.getElementById("line_endX").value;
            line.endY = document.getElementById("line_endY").value;
            line.lineCap = document.getElementById("line_cap").value;
            line.lineJoin = document.getElementById("line_join").value;
            line.width = document.getElementById("line_width").value;
            line.strokeStyle = document.getElementById("line_color").value;
            annotationObjects.push(line);
            break;
        case "rect":
            var rect = new RectObj();
            rect.x = document.getElementById("rect_startX").value;
            rect.y = document.getElementById("rect_startY").value;
            rect.width = document.getElementById("rect_width").value;
            rect.height = document.getElementById("rect_height").value;
            rect.lineWidth = document.getElementById("rect_lineWidth").value;
            rect.strokeStyle = document.getElementById("rect_color").value;
            annotationObjects.push(rect);
            break;
        case "arc":
            var arc = new ArcObj();
            arc.x = document.getElementById("arc_startX").value;
            arc.y = document.getElementById("arc_startY").value;
            arc.startAngle = document.getElementById("arc_startA").value / 180 * Math.PI;
            arc.endAngle = document.getElementById("arc_endA").value / 180 * Math.PI;
            arc.width = document.getElementById("arc_width").value;
            arc.radius = document.getElementById("arc_radius").value;
            arc.strokeStyle = document.getElementById("arc_color").value;
            annotationObjects.push(arc);
            break;
        case "text":
            var text = new TextObj();
            text.x = document.getElementById("text_startX").value;
            text.y = document.getElementById("text_startY").value;
            text.text = document.getElementById("text_text").value;
            text.font = document.getElementById("text_font").value;
            text.textAlign = document.getElementById("text_align").value;
            text.lineWidth = document.getElementById("text_width").value;
            text.strokeStyle = document.getElementById("text_color").value;
            annotationObjects.push(text);
            break;
        case "image":
            var img = new ImgObj();
            img.x = document.getElementById("img_startX").value;
            img.y = document.getElementById("img_startY").value;
            img.width = document.getElementById("img_width").value;
            img.height = document.getElementById("img_height").value;
            annotationObjects.push(img);
            break;
    }
}

function clearAnnotations() {
    annotationObjects = new Array();
}

