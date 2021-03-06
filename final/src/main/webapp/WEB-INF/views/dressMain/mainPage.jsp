<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>

  .svg-contain {
    max-width: 150px;
    margin: 20px;
    width: 100%;
  }
  
  .weather-container {
      width:100%;
      height: 800px;
        display: flex;
     justify-content: center;
     align-items: center;
  
  }
  
  .big-path,
  .lightening,
  .line,
  .little-path {
    stroke-miterlimit: 10;
    stroke-width: 2;
    stroke-linecap: round;
    fill: none;
  }
  
  .cloud {
    fill: #DAD9D9;
  }
  
  .little-path {
    stroke-width: 1;
  }
  
  .hurricane-svg .line {
    stroke: #BAE2E0;
    opacity: 1;
    animation: fadeIn 0.8s ease-in alternate-reverse infinite;
  }
  .hurricane-svg .line:nth-child(1) {
    -webkit-animation-delay: 0.1s;
            animation-delay: 0.1s;
  }
  .hurricane-svg .line:nth-child(2) {
    -webkit-animation-delay: 0.2s;
            animation-delay: 0.2s;
  }
  .hurricane-svg .line:nth-child(3) {
    -webkit-animation-delay: 0.3s;
            animation-delay: 0.3s;
  }
  .hurricane-svg .line:nth-child(4) {
    -webkit-animation-delay: 0.4s;
            animation-delay: 0.4s;
  }
  .hurricane-svg .line:nth-child(5) {
    -webkit-animation-delay: 0.5s;
            animation-delay: 0.5s;
  }
  .hurricane-svg .line:nth-child(6) {
    -webkit-animation-delay: 0.6s;
            animation-delay: 0.6s;
  }
  .hurricane-svg .line:nth-child(7) {
    -webkit-animation-delay: 0.7s;
            animation-delay: 0.7s;
  }
  .hurricane-svg .line:nth-child(8) {
    -webkit-animation-delay: 0.8s;
            animation-delay: 0.8s;
  }
  .hurricane-svg .line:nth-child(9) {
    -webkit-animation-delay: 0.9s;
            animation-delay: 0.9s;
  }
  .hurricane-svg .line:nth-child(10) {
    -webkit-animation-delay: 1s;
            animation-delay: 1s;
  }
  .hurricane-svg .line:nth-child(11) {
    -webkit-animation-delay: 1.1s;
            animation-delay: 1.1s;
  }
  .hurricane-svg .line:nth-child(12) {
    -webkit-animation-delay: 1.2s;
            animation-delay: 1.2s;
  }
  .hurricane-svg .lightening {
    -webkit-animation: flash 1s infinite;
            animation: flash 1s infinite;
    stroke: #E5D8BA;
  }
  .hurricane-svg .big-path,
  .hurricane-svg .little-path {
    stroke: #BAE2E0;
  }
  .hurricane-svg .big-path {
    stroke-width: 1;
  }
  .hurricane-svg .little-path {
    stroke-width: 0.5;
  }
  .hurricane-svg .cloud {
    -webkit-animation: colorChange 1s infinite;
            animation: colorChange 1s infinite;
  }
  
  .windy-svg .little-path,
  .windy-svg .big-path {
    animation: dash 1s ease-in alternate-reverse infinite, fadeIn 1s alternate-reverse infinite;
  }
  .windy-svg path {
    stroke: #BAE2E0;
  }
  .windy-svg .path-1 {
    stroke-dasharray: 7;
    stroke-dashoffset: 7;
  }
  .windy-svg .path-2 {
    stroke-dasharray: 25;
    stroke-dashoffset: -25;
  }
  .windy-svg .path-3 {
    stroke-dasharray: 30;
    stroke-dashoffset: 30;
  }
  .windy-svg .path-4 {
    stroke-dasharray: 8;
    stroke-dashoffset: 8;
  }
  .windy-svg .path-5 {
    stroke-dasharray: 22;
    stroke-dashoffset: -22;
  }
  .windy-svg .big-path-1 {
    stroke-dasharray: 57;
    stroke-dashoffset: 57;
  }
  .windy-svg .big-path-2 {
    stroke-dasharray: 76;
    stroke-dashoffset: 76;
  }
  
  .clear-sky-svg {
    animation: expand 0.8s alternate-reverse infinite;
  }
  .clear-sky-svg .sun {
    fill: #E5D8BA;
  }
  .clear-sky-svg .line {
    stroke: #E5D8BA;
    stroke-dasharray: 7;
    animation: dash 0.8s alternate-reverse infinite, fadeIn 1s forwards;
  }
  .clear-sky-svg .line-1,
  .clear-sky-svg .line-3,
  .clear-sky-svg .line-5,
  .clear-sky-svg .line-7,
  .clear-sky-svg .line-4 {
    stroke-dashoffset: 5;
    -webkit-animation-delay: 0.3s;
            animation-delay: 0.3s;
  }
  .clear-sky-svg .line-2,
  .clear-sky-svg .line-6,
  .clear-sky-svg .line-8 {
    stroke-dashoffset: -5;
  }
  
  .overcast-clouds .cloud-still {
    fill: #DAD9D9;
    animation: bounce 4s ease-in-out alternate-reverse infinite;
  }
  .overcast-clouds .cloud-still:nth-child(1) {
    -webkit-animation-delay: 0.2s;
            animation-delay: 0.2s;
  }
  
  .snow-svg .snowflake {
    transform-origin: 50% 50%;
    transform: translateY(-10px);
    opacity: 0;
  }
  .snow-svg .snowflake:nth-child(1) {
    -webkit-animation: fall-counterclockwise 2658ms ease-in forwards infinite;
            animation: fall-counterclockwise 2658ms ease-in forwards infinite;
    -webkit-animation-delay: 0.1s;
            animation-delay: 0.1s;
  }
  .snow-svg .snowflake:nth-child(2) {
    -webkit-animation: fall-clockwise 2556ms ease-in forwards infinite;
            animation: fall-clockwise 2556ms ease-in forwards infinite;
    -webkit-animation-delay: 0.4s;
            animation-delay: 0.4s;
  }
  .snow-svg .snowflake:nth-child(3) {
    -webkit-animation: fall-counterclockwise 2125ms ease-in forwards infinite;
            animation: fall-counterclockwise 2125ms ease-in forwards infinite;
    -webkit-animation-delay: 0.6s;
            animation-delay: 0.6s;
  }
  .snow-svg .snowflake:nth-child(4) {
    -webkit-animation: fall-clockwise 2966ms ease-in forwards infinite;
            animation: fall-clockwise 2966ms ease-in forwards infinite;
    -webkit-animation-delay: 1.2s;
            animation-delay: 1.2s;
  }
  .snow-svg .snowflake:nth-child(5) {
    -webkit-animation: fall-counterclockwise 3041ms ease-in forwards infinite;
            animation: fall-counterclockwise 3041ms ease-in forwards infinite;
    -webkit-animation-delay: 1.5s;
            animation-delay: 1.5s;
  }
  .snow-svg .snowflake:nth-child(6) {
    -webkit-animation: fall-clockwise 3009ms ease-in forwards infinite;
            animation: fall-clockwise 3009ms ease-in forwards infinite;
    -webkit-animation-delay: 1.8s;
            animation-delay: 1.8s;
  }
  .snow-svg .snowflake:nth-child(7) {
    -webkit-animation: fall-counterclockwise 3056ms ease-in forwards infinite;
            animation: fall-counterclockwise 3056ms ease-in forwards infinite;
    -webkit-animation-delay: 0.7s;
            animation-delay: 0.7s;
  }
  .snow-svg .snowflake:nth-child(8) {
    -webkit-animation: fall-clockwise 2411ms ease-in forwards infinite;
            animation: fall-clockwise 2411ms ease-in forwards infinite;
    -webkit-animation-delay: 0.8s;
            animation-delay: 0.8s;
  }
  .snow-svg .snowflake:nth-child(9) {
    -webkit-animation: fall-counterclockwise 2499ms ease-in forwards infinite;
            animation: fall-counterclockwise 2499ms ease-in forwards infinite;
    -webkit-animation-delay: 2.7s;
            animation-delay: 2.7s;
  }
  .snow-svg .snowflake:nth-child(10) {
    -webkit-animation: fall-clockwise 2834ms ease-in forwards infinite;
            animation: fall-clockwise 2834ms ease-in forwards infinite;
    -webkit-animation-delay: 2s;
            animation-delay: 2s;
  }
  .snow-svg .snowflake-path {
    stroke: #BAE2E0;
    stroke-width: 1;
  }
  
  .fog-svg .fog-line:nth-child(1) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 0.2s;
            animation-delay: 0.2s;
  }
  .fog-svg .fog-line:nth-child(2) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 0.4s;
            animation-delay: 0.4s;
  }
  .fog-svg .fog-line:nth-child(3) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 0.6s;
            animation-delay: 0.6s;
  }
  .fog-svg .fog-line:nth-child(4) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 0.8s;
            animation-delay: 0.8s;
  }
  .fog-svg .fog-line:nth-child(5) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 1s;
            animation-delay: 1s;
  }
  .fog-svg .fog-line:nth-child(6) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 1.2s;
            animation-delay: 1.2s;
  }
  .fog-svg .fog-line:nth-child(7) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 1.4s;
            animation-delay: 1.4s;
  }
  .fog-svg .fog-line:nth-child(8) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 1.6s;
            animation-delay: 1.6s;
  }
  .fog-svg .fog-line:nth-child(9) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 1.8s;
            animation-delay: 1.8s;
  }
  .fog-svg .fog-line:nth-child(10) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 2s;
            animation-delay: 2s;
  }
  .fog-svg .fog-line:nth-child(11) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 2.2s;
            animation-delay: 2.2s;
  }
  .fog-svg .fog-line:nth-child(12) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 2.4s;
            animation-delay: 2.4s;
  }
  .fog-svg .fog-line:nth-child(13) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 2.6s;
            animation-delay: 2.6s;
  }
  .fog-svg .fog-line:nth-child(14) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 2.8s;
            animation-delay: 2.8s;
  }
  .fog-svg .fog-line:nth-child(15) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 3s;
            animation-delay: 3s;
  }
  .fog-svg .fog-line:nth-child(16) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 3.2s;
            animation-delay: 3.2s;
  }
  .fog-svg .fog-line:nth-child(17) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 3.4s;
            animation-delay: 3.4s;
  }
  .fog-svg .fog-line:nth-child(18) {
    stroke: #BAE2E0;
    animation: pan 10s ease-in-out forwards infinite, fadeIn 4s alternate-reverse infinite;
    -webkit-animation-delay: 3.6s;
            animation-delay: 3.6s;
  }
  
  @-webkit-keyframes colorChange {
    0%, 90% {
      fill: #646478;
    }
    60%, 100% {
      fill: rgba(200, 200, 200, 0.8);
    }
  }
  
  @keyframes colorChange {
    0%, 90% {
      fill: #646478;
    }
    60%, 100% {
      fill: rgba(200, 200, 200, 0.8);
    }
  }
  @-webkit-keyframes fadeIn {
    0% {
      opacity: 0;
    }
    100% {
      opacity: 1;
    }
  }
  @keyframes fadeIn {
    0% {
      opacity: 0;
    }
    100% {
      opacity: 1;
    }
  }
  @-webkit-keyframes flash {
    0%, 90% {
      opacity: 0;
      transform: translateX(-1px) translateY(-2px) rotate(0.01deg);
    }
    90% {
      transform: translateX(1px) translateY(-1px);
    }
    60%, 100% {
      opacity: 1;
      transform: translateX(0px) translateY(0px);
    }
  }
  @keyframes flash {
    0%, 90% {
      opacity: 0;
      transform: translateX(-1px) translateY(-2px) rotate(0.01deg);
    }
    90% {
      transform: translateX(1px) translateY(-1px);
    }
    60%, 100% {
      opacity: 1;
      transform: translateX(0px) translateY(0px);
    }
  }
  @-webkit-keyframes expand {
    to {
      transform: scale(1.1);
    }
  }
  @keyframes expand {
    to {
      transform: scale(1.1);
    }
  }
  @-webkit-keyframes dash {
    to {
      stroke-dashoffset: 0;
    }
  }
  @keyframes dash {
    to {
      stroke-dashoffset: 0;
    }
  }
  @-webkit-keyframes bounce {
    0%, 50%, 100% {
      transform: translateY(0px) translateX(0px) rotate(0.1deg);
    }
    30%, 80% {
      transform: translateY(3px) translateX(3px) rotate(0.1deg);
    }
  }
  @keyframes bounce {
    0%, 50%, 100% {
      transform: translateY(0px) translateX(0px) rotate(0.1deg);
    }
    30%, 80% {
      transform: translateY(3px) translateX(3px) rotate(0.1deg);
    }
  }
  @-webkit-keyframes fall-clockwise {
    0% {
      transform: translateY(-7px) rotate(0) scale(0.5);
      opacity: 0;
    }
    10% {
      transform: translateY(-4px) translateX(4px) rotate(-30deg) scale(0.7);
      opacity: 1;
    }
    45% {
      transform: translateY(5px) translateX(0px) rotate(30deg) scale(0.6);
    }
    50% {
      opacity: 0;
    }
    100% {
      opacity: 0;
      transform: translateY(10px) translateX(3px) scale(0.5);
    }
  }
  @keyframes fall-clockwise {
    0% {
      transform: translateY(-7px) rotate(0) scale(0.5);
      opacity: 0;
    }
    10% {
      transform: translateY(-4px) translateX(4px) rotate(-30deg) scale(0.7);
      opacity: 1;
    }
    45% {
      transform: translateY(5px) translateX(0px) rotate(30deg) scale(0.6);
    }
    50% {
      opacity: 0;
    }
    100% {
      opacity: 0;
      transform: translateY(10px) translateX(3px) scale(0.5);
    }
  }
  @-webkit-keyframes fall-counterclockwise {
    0% {
      transform: translateY(-9px) rotate(0) scale(0.6);
      opacity: 0;
    }
    10% {
      transform: translateY(-4px) translateX(-4px) rotate(30deg) scale(0.7);
      opacity: 1;
    }
    40% {
      transform: translateY(8px) translateX(4px) rotate(-30deg) scale(0.8);
    }
    50% {
      opacity: 0;
    }
    100% {
      opacity: 0;
      transform: translateY(14px) translateX(-3px) scale(0.7);
    }
  }
  @keyframes fall-counterclockwise {
    0% {
      transform: translateY(-9px) rotate(0) scale(0.6);
      opacity: 0;
    }
    10% {
      transform: translateY(-4px) translateX(-4px) rotate(30deg) scale(0.7);
      opacity: 1;
    }
    40% {
      transform: translateY(8px) translateX(4px) rotate(-30deg) scale(0.8);
    }
    50% {
      opacity: 0;
    }
    100% {
      opacity: 0;
      transform: translateY(14px) translateX(-3px) scale(0.7);
    }
  }
  @-webkit-keyframes pan {
    0%, 100% {
      transform: translateX(-2px) rotate(0.01deg);
    }
    50% {
      transform: translateX(2px) rotate(0.01deg);
    }
  }
  @keyframes pan {
    0%, 100% {
      transform: translateX(-2px) rotate(0.01deg);
    }
    50% {
      transform: translateX(2px) rotate(0.01deg);
    }
  }



  .Mainmain{
      width: 100%;
      height:1000px;
      background: #333;
  }
  .weatherCheck{
      width:600px;
      text-align: center;
      
      position: relative;
      top:200px;
      margin: 0 auto;  
    }
    .loading > a{
        text-decoration: none;
        color: white;
        font-size: 30px;
    }
 
  .loading span {
    display: inline-block;
    margin: 0 -.05em;
    animation: loading .7s infinite;
  }
  .loading span:nth-child(2) {
    animation-delay: .1s;
  }
  .loading span:nth-child(3) {
    animation-delay: .2s;
  }
  .loading span:nth-child(4) {
    animation-delay: .3s;
  }
  .loading span:nth-child(5) {
    animation-delay: .4s;
  }
  .loading span:nth-child(6) {
    animation-delay: .5s;
  }
  .loading span:nth-child(7) {
    animation-delay: .6s;
  }
  @keyframes loading {
    0%, 100% {
      transform: translateY(0);
    }
    50% {
      transform: translateY(15px);
    }
  }
</style>

  <div class="Mainmain">
        <section class="sectionMain-1">
           <div class="weatherCheck">
            <div class="loading">
               <a href="${pageContext.request.contextPath}/dressMain/main"><span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span>
                <span>???</span></a>
              </div>
           </div>
            <div class="weather-container">
                <div class="svg-contain">
                    <svg class="hurricane-svg" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="-437 254.4 85 52.6"
                        style="enable-background:new -437 254.4 85 52.6;" xml:space="preserve">
                        <path class="cloud" d="M-361.9,280.5c1.4,0,2.6,0.7,3.4,1.7h1.1c0.4-8.2-5.9-10.8-5.9-10.8c-2.2-1.5-5.4-1-5.4-1
    c-0.1-4.1-2.9-7.4-2.9-7.4c-4.7-5.5-10.3-4.9-10.3-4.9c-7.4-0.2-11,5.9-11,5.9c-5.6-4-14.3-2.6-18.2,3.1c-0.7,1.1-1.3,2.2-1.8,3.4
    c0,0.1-0.3,1.2-0.4,1.2c3.5-0.6,6.6,1.6,6.6,1.6s1.1-1.1,1.2-1.3c2.4-2.4,5.6-3.6,9-3.2c4.4,0.5,8.5,3,9.9,7.4
    c0.1,0.2,0.8,2.4,0.6,2.4c5.3,0.1,7.3,3.6,7.3,3.6h13.4C-364.5,281.2-363.3,280.5-361.9,280.5z" />
                        <path class="cloud" d="M-386,279.6c-0.2,0-0.4,0-0.6,0.1c-0.1-0.8-0.2-1.7-0.4-2.4c-0.3-1-0.8-2-1.4-2.9c-2-2.9-5.3-4.8-9-4.8
    c-2.3,0-4.4,0.7-6.1,1.9c-0.6,0.4-1.1,0.8-1.6,1.3c-0.2,0.2-0.5,0.5-0.7,0.8c-0.2,0.3-0.4,0.5-0.6,0.8c-1.8-1.2-3.9-1.9-6.2-1.9
    c-5.5,0-10,4-10.8,9.3c-3.5,1-6.1,3.9-6.6,7.6h26.3h12.7h2.3l4.7-6.2c0.6-0.8,1.7-0.9,2.5-0.3s0.9,1.7,0.3,2.5l-3.1,4h0.5h5.6h0.7
    c0.1,0,0.2-0.4,0.2-1.1C-377.4,283.5-381.3,279.6-386,279.6z" />
                        <polyline class="lightening" points="-382.8,284.2 -387.9,290.9 -380.6,291.2 -387.9,302 " />
                        <path class="line" d="M-426.9,294.4l-5.1,7.3" />
                        <path class="line" d="M-420.8,294.4l-5.1,7.3" />
                        <path class="line" d="M-415.4,294.4l-5.1,7.3" />
                        <path class="line" d="M-409.9,294.4l-5.1,7.3" />
                        <path class="line" d="M-404.5,294.4l-5.1,7.3" />
                        <path class="line" d="M-399.1,294.4l-5.1,7.3" />
                        <path class="line" d="M-393.7,294.4l-5.1,7.3" />
                        <path class="line" d="M-388.2,294.4l-5.1,7.3" />
                        <g>
                            <path class="little-path path-1" d="M-374.8,287.2h10.6" />
                            <path class="little-path path-2" d="M-373.8,289.3h10.9" />
                            <path class="big-path" d="M-376,288.3c0,0,14,0,14,0c1.7,0,3.1-1.4,3.3-3.1c0-0.5,0-1-0.3-1.4c-0.9-2.3-4.1-2.7-5.6-0.7
        c-0.4,0.6-0.7,1.3-0.7,1.9" />
                            <path class="little-path path-3"
                                d="M-364.1,285c0-1.2,1-2.2,2.2-2.2s2.2,1,2.2,2.2c0,1.2-1,2.2-2.2,2.2" />
                        </g>
                    </svg>
                </div>
                <div class="svg-contain">
                    <svg version="1.1" class="clear-sky-svg" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 72.3 52.6"
                        style="enable-background:new 0 0 72.3 52.6;" xml:space="preserve">
                        <g>
                            <path class="sun"
                                d="M50.8,25.7c0,7.9-6.4,14.4-14.4,14.4s-14.4-6.4-14.4-14.4s6.4-14.4,14.4-14.4S50.8,17.8,50.8,25.7z" />
                            <path class="line big-path line-1" d="M54.5,25.8h6" />
                            <path class="line big-path line-2" d="M12.4,25.8h6" />
                            <path class="line big-path line-3" d="M36.5,44.3v6" />
                            <path class="line big-path line-4" d="M36.5,8.2v-6" />
                            <path class="line big-path line-5" d="M23,38.8l-4.8,4.8" />
                            <path class="line big-path line-6" d="M54.9,8.9L50,13.8" />
                            <path class="line big-path line-7" d="M50,38.8l4.4,4.4" />
                            <path class="line big-path line-8" d="M18.8,9.6l4.2,4.2" />
                        </g>
                    </svg>
                </div>
                <div class="svg-contain">
                    <svg version="1.1" class="windy-svg" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="-447 254.4 64 52.6"
                        style="enable-background:new -447 254.4 64 52.6;" xml:space="preserve">
                        <g id="Layer_1_1_">
                            <g>
                                <path class="st0 little-path path-1" d="M-429.2,276.8h6.3" />
                                <path class="big-path big-path-1" d="M-438.1,279.3c0,0,20.5,0,20.6,0c4.1,0,7.4-3.4,7.7-7.4c0.1-1.1-0.1-2.3-0.6-3.3c-2.2-5.4-9.8-6.3-13.3-1.7
            c-1,1.3-1.6,3-1.7,4.6" />
                                <path class="little-path path-2"
                                    d="M-422.6,271.7c0-2.8,2.3-5.1,5.1-5.1s5.1,2.3,5.1,5.1c0,2.8-2.3,5.1-5.1,5.1" />
                            </g>
                            <g>
                                <path class="little-path path-3" d="M-434.1,284.9h30.4" />
                                <path class="little-path path-4" d="M-410.6,280h8.7" />
                                <path class="big-path big-path-2"
                                    d="M-442.9,282.7h44c3.6,0,6.6,3,6.8,6.5c0.1,1-0.1,2-0.5,3c-2,4.8-8.7,5.5-11.8,1.5c-0.9-1.2-1.4-2.6-1.5-4.1" />
                                <path class="little-path path-5"
                                    d="M-403.4,289.4c0,2.5,2,4.5,4.5,4.5s4.5-2,4.5-4.5s-2-4.5-4.5-4.5" />
                            </g>
                        </g>
                    </svg>
                </div>
                <div class="svg-contain">
                    <svg class="overcast-clouds" version="1.1" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 82.6 52.3"
                        style="enable-background:new 0 0 82.6 52.3;" xml:space="preserve">
                        <g id="Layer_1">
                            <path class="cloud-still" d="M21.8,24.2c0.1,0,0.3-1.1,0.4-1.2c0.5-1.2,1.1-2.4,1.8-3.4c3.9-5.7,12.6-7.1,18.2-3.1c0,0,3.7-6,11-5.9
    c0,0,5.6-0.6,10.3,4.9c0,0,2.8,3.3,2.9,7.4c0,0,3.2-0.5,5.4,1c0,0,6.2,2.6,5.9,10.8H56.3c0,0-2-3.5-7.3-3.6c0.2,0-0.5-2.2-0.6-2.4
    c-1.4-4.4-5.5-6.9-9.9-7.4c-3.4-0.4-6.6,0.8-9,3.2c-0.1,0.1-1.2,1.3-1.2,1.3S25.3,23.6,21.8,24.2z" />
                            <path class="cloud-still"
                                d="M57.6,40.7c0-4.8-3.9-8.6-8.6-8.6c-0.2,0-0.4,0-0.6,0.1c-0.1-0.8-0.2-1.7-0.4-2.4c-0.3-1-0.8-2-1.4-2.9
    c-2-2.9-5.3-4.8-9-4.8c-2.3,0-4.4,0.7-6.1,1.9c-0.6,0.4-1.1,0.8-1.6,1.3c-0.2,0.2-0.5,0.5-0.7,0.8c-0.2,0.3-0.4,0.5-0.6,0.8
    c-1.8-1.2-3.9-1.9-6.2-1.9c-5.5,0-10,4-10.8,9.3c-3.5,1-6.1,3.9-6.6,7.6h26.3h12.7h12.9h0.7C57.6,41.8,57.6,41.4,57.6,40.7z" />
                        </g>
                        <g id="Layer_2">
                        </g>
                    </svg></div>
                <div class="svg-contain">
                    <svg version="1.1" class="snow-svg" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 70.3 52.6"
                        style="enable-background:new 0 0 70.3 52.6;" xml:space="preserve">
                        <g id="Layer_1">
                            <path class="cloud"
                                d="M63.9,30.9c0-5.2-4.2-9.4-9.4-9.4c-0.2,0-0.4,0.1-0.7,0.1c-0.1-0.9-0.2-1.8-0.5-2.7c-0.3-1.1-0.9-2.2-1.5-3.1
    c-2.1-3.2-5.8-5.3-9.9-5.3c-2.5,0-4.8,0.7-6.7,2c-0.6,0.4-1.2,0.9-1.8,1.5c-0.3,0.3-0.5,0.6-0.8,0.8c-0.2,0.3-0.5,0.6-0.7,0.9
    c-1.9-1.3-4.2-2.1-6.7-2.1c-6,0-10.9,4.4-11.8,10.1c-3.8,1.1-6.7,4.3-7.2,8.3h28.7h13.9H63h0.8C63.9,32.1,63.9,31.7,63.9,30.9z" />
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="10.3" y1="37" x2="10.3" y2="43.5" />
                                <line class="snowflake-path big-path" x1="13.5" y1="40.3" x2="7" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="12.6" y1="38" x2="8" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="12.6" y1="42.6" x2="8" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="22.7" y1="37" x2="22.7" y2="43.5" />
                                <line class="snowflake-path big-path" x1="25.9" y1="40.3" x2="19.4" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="25" y1="38" x2="20.4" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="25" y1="42.6" x2="20.4" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="35.2" y1="37" x2="35.2" y2="43.5" />
                                <line class="snowflake-path big-path" x1="38.4" y1="40.3" x2="31.9" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="37.5" y1="38" x2="32.9" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="37.5" y1="42.6" x2="32.9" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="48.3" y1="37" x2="48.3" y2="43.5" />
                                <line class="snowflake-path big-path" x1="51.6" y1="40.3" x2="45" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="50.6" y1="38" x2="46" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="50.6" y1="42.6" x2="46" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="60.5" y1="37" x2="60.5" y2="43.5" />
                                <line class="snowflake-path big-path" x1="63.7" y1="40.3" x2="57.2" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="62.8" y1="38" x2="58.2" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="62.8" y1="42.6" x2="58.2" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="10.3" y1="37" x2="10.3" y2="43.5" />
                                <line class="snowflake-path big-path" x1="13.5" y1="40.3" x2="7" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="12.6" y1="38" x2="8" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="12.6" y1="42.6" x2="8" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="22.7" y1="37" x2="22.7" y2="43.5" />
                                <line class="snowflake-path big-path" x1="25.9" y1="40.3" x2="19.4" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="25" y1="38" x2="20.4" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="25" y1="42.6" x2="20.4" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="35.2" y1="37" x2="35.2" y2="43.5" />
                                <line class="snowflake-path big-path" x1="38.4" y1="40.3" x2="31.9" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="37.5" y1="38" x2="32.9" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="37.5" y1="42.6" x2="32.9" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="48.3" y1="37" x2="48.3" y2="43.5" />
                                <line class="snowflake-path big-path" x1="51.6" y1="40.3" x2="45" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="50.6" y1="38" x2="46" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="50.6" y1="42.6" x2="46" y2="38" />
                                </g>
                            </g>
                            <g class="snowflake">
                                <line class="snowflake-path big-path" x1="60.5" y1="37" x2="60.5" y2="43.5" />
                                <line class="snowflake-path big-path" x1="63.7" y1="40.3" x2="57.2" y2="40.3" />
                                <g>
                                    <line class="snowflake-path big-path" x1="62.8" y1="38" x2="58.2" y2="42.6" />
                                    <line class="snowflake-path big-path" x1="62.8" y1="42.6" x2="58.2" y2="38" />
                                </g>
                            </g>
                        </g>
                    </svg>
                </div>
                <div class="svg-contain">
                    <svg class="fog-svg" version="1.1" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 68 52.6"
                        style="enable-background:new 0 0 68 52.6;" xml:space="preserve">
                        <g id="Layer_1">
                            <g>
                                <path class="cloud st3"
                                    d="M62.8,29.3c0-5.2-4.2-9.4-9.4-9.4c-0.2,0-0.4,0.1-0.7,0.1c-0.1-0.9-0.2-1.8-0.5-2.7c-0.3-1.1-0.9-2.2-1.5-3.1
        C48.6,11,44.9,9,40.8,9c-2.5,0-4.8,0.7-6.7,2c-0.6,0.4-1.2,0.9-1.8,1.5c-0.3,0.3-0.5,0.6-0.8,0.8c-0.2,0.3-0.5,0.6-0.7,0.9
        c-1.9-1.3-4.2-2.1-6.7-2.1c-6,0-10.9,4.4-11.8,10.1c-3.8,1.1-6.7,4.3-7.2,8.3h28.7h13.9h14.1h0.8C62.7,30.6,62.8,30.1,62.8,29.3z" />
                                <path class="fog-line big-path" d="M7.3,28.8h12.4" />
                                <path class="fog-line big-path" d="M23.5,28.8h38.4" />
                                <path class="fog-line big-path" d="M57.3,32.6h5.2" />
                                <path class="fog-line big-path" d="M31.2,32.6h22.1" />
                                <path class="fog-line big-path" d="M6.2,32.6h21.1" />
                                <path class="fog-line big-path" d="M11.4,43.6H6.2" />
                                <path class="fog-line big-path" d="M37.5,43.6H15.4" />
                                <path class="fog-line big-path" d="M62.5,43.6H41.4" />
                                <path class="fog-line big-path" d="M6.2,36.4h2.1" />
                                <path class="fog-line big-path" d="M11.9,36.4h6" />
                                <path class="fog-line big-path" d="M21.8,36.4h20.4" />
                                <path class="fog-line big-path" d="M46.3,36.4h16.1" />
                                <path class="fog-line big-path" d="M55.2,40.2h7.3" />
                                <path class="fog-line big-path" d="M48.3,40.2h2.8" />
                                <path class="fog-line big-path" d="M37.3,40.2H44" />
                                <path class="fog-line big-path" d="M18.3,40.2h15.3" />
                                <path class="fog-line big-path" d="M6.2,40.2h8" />
                            </g>
                        </g>
                    </svg>
                </div>
            </div>
           
        </section>
    </div>
   