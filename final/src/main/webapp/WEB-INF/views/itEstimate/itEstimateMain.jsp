<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.estimate_banner{
    height: 260px;
    background: url('${pageContext.request.contextPath}/resources/images/interior/interior_bb.jpg');
    margin-top: 100px;
    padding: 120px 0px;
    text-align: center;
}

.estimate_banner_content{

    font-size: 50px;
    font-weight: 100;
    color: aliceblue;

    margin-bottom: 50px;
}

.estimate_banner_content span{
    font-weight: 700;
    font-size: 55px;

}
.estimate_banner_content_sub{
    color: rgba(240, 248, 255, 0.829);
    font-size: 25px;
    margin-top: -20px;
}

.estimate_banner_sendbutton{
    margin-top: 80px;
}

.estimate_banner_sendbutton_button{
    width: 250px;
    height: 80px;
    border-radius: 40px;
    background: #35c5f0;
    border: #35c5f0;
    color: white;
    font-size: 25px;
    font-weight: 700;
}

.estimate_sogae{
    width: 85%;
    display: flex;
    justify-content: center;
    margin: 0 auto;
    
}

.estimate_sogae_box{
    padding-top: 100px;
    padding-bottom: 120px;


}
.estimate_sogae_items_box{
    width: 32%;
    margin-left: 10px;
    margin-right: 10px;
}

.estimate_sogae_item_imgbox{
    width: 100%;
    text-align: center;
}

.estimate_sogae_item_imgbox img{
    width: 80%;
    height: 400px;
    
}

.estimate_sogae_item_contentbox{
    width: 100%;
    
}

.estimate_sogae_item_contentbox p{
    width: 100%;
    font-size: 30px;
    letter-spacing: -3px;
    font-weight: 600;
    text-align: center;
    padding: 20px 0px;
    
}

#contentbox_sub_p{
    font-size: 23px;
    color: rgba(0, 0, 0, 0.644);
}

.estimate_jin{
    text-align: center;
    margin-top: 200px;
    width: 100%;
    height: 800px;
    background: url('${pageContext.request.contextPath}/resources/images/interior/interior_jin2.png');
    background-position: 50%;

}

.estimate_list_box{

    background: white;
    width: 600px;
    margin: 0 auto;
    position: absolute;
    left :50%; 
    transform:translateX(-50%);
    border-radius: 15px;
    box-shadow: 0 5px 2px rgba(0, 0, 0, 0.5);

}

.estimate_list_controller{
    width: 90%;
    margin: 0 auto;

}

.estimate_list_ingbar{
    display: flex;
    height: 100%;
    width: 100%;
    margin: 0 auto;
    margin-top: 20px;
}

.estimate_list_ingbar_ing{
    height: 10px;
    background: #35c5f0;
    border-radius: 10px 0 0 10px;
}
.estimate_list_ingbar_non{
    height: 10px;
    background-color: #dbdbdb;
    border-radius: 0 10px 10px 0;
}

.estimate_list_ingbar_text{
    width: 100%;
    height: 60px;
}

.estimate_list_ingbar_text p{
    text-align: left;
    color: #35c5f0;
    margin-top: 2px;
    font-weight: 500;
    font-size: 18px;
}

.estimate_list_content{
    padding-top: 10px;
    padding-bottom: 10px;
    height: 40px;
    text-align: left;
    border-bottom: 1px solid #dbdbdb ;
}

.estimate_list_h1{
    height: 60px;
    text-align: left;
}

.estimate_list_content_check{
    width: 25px;
    height: 25px;
    
}
.estimate_list_content span{
    padding-left: 10px;
    font-size: 18px;
    font-weight: 500;
    
}
.estimate_list_buttonbox{
    width: 100%;
    margin-top: 60px;
    margin-bottom: 50px;
    height: 50px;
    display: flex;
}

.estimate_list_button{
    width: 100%;
    height: 100%;
    border-radius: 5px;
    border: #35c5f0;
    background: #dbdbdb;
    color: balck;
}

.estimate_list_prebutton{
    width: 50%;
    height: 100%;
    margin-right: 10px;
    border-radius: 5px;
    border: #dbdbdb;
    background: #dbdbdb;
}

.estimate_list_content_memobox{
    width: 100%;
    height: 300px;
}

.estimate_list_content_memo{
    width: 100%;
    height: 100%;
    font-size: 20px;
    border: 1px solid #dbdbdb;
    resize : none;
}

.estimate_list_content_input{
    width: 60%;
    height: 100%;
    border-radius: 4px;
    border: none;
    font-size: 20px;

}
</style>

<script>

$(function(){
	$(".content_memo").on("keyup" ,function(){
		$(".estimate_list_button").removeAttr("disabled");
		$(".estimate_list_button").css("background","#35c5f0");
	});
	
	$(".estimate_banner_sendbutton_button").click(function(){
		$(".estimate_banner_sendbutton_button").hide();
		$(".estimate_list_controller:first").show();
		
		$(".estimate_list_content_check").click(function(){
			$(".estimate_list_button").removeAttr("disabled");
			$(".estimate_list_button").css("background","#35c5f0");
		});
		

	});
		
		
		$(".estimate_list_button").click(function(){

						
		
			if (! $(".estimate_list_controller").last().is(":visible")) { // last() ????????? ??? ?????? 
				$(".estimate_list_controller:visible").hide().next(".estimate_list_controller").fadeIn(100); //fadeIn??? ??????????????? ???????????? ?????? ??????. show ?????? ???		
				$(".estimate_list_button").attr("disabled");
				$(".estimate_list_button").css("background","#dbdbdb");
				$(".estimate_list_button").addClass("last");
			}
				
		});
		
	
	
	$(".estimate_input_name").on("keyup",function(){
		var $input = $(".estimate_input_name").val();
		var $tel = $(".estimate_input_tel").val();
		if($input.length > 2 && $tel.length > 11){
			$(".estimate_list_button").removeAttr("disabled");
			$(".estimate_list_button").css("background","#35c5f0");
		}else{
			$(".estimate_list_button").attr("disabled");
			$(".estimate_list_button").css("background","#dbdbdb");
		}
	});
	
	$(".estimate_input_tel").on("keyup",function(){
		var $input = $(".estimate_input_name").val();
		var $tel = $(".estimate_input_tel").val();
		if($input.length > 2 && $tel.length > 11){
			$(".estimate_list_button").removeAttr("disabled");
			$(".estimate_list_button").css("background","#35c5f0");
		}else{
			$(".estimate_list_button").attr("disabled");
			$(".estimate_list_button").css("background","#dbdbdb");
		}
	});
	
	$(".last").click(function(){
		var f = document.estimate_list;
		
		//?????? ????????? ????????? required???????????? ????????? ???????
		str = f.userName.value;
		str = str.trim();
		if(!str) {
			alert("????????? ???????????????.");
			f.userName.focus();
			return;
		}
		str = f.tel.value;
		str = str.trim();
		if(!str) {
			alert("??????????????? ???????????????.");
			f.tel.focus();
			return;
		}	
	
		// ????????? ?????????????????? ?????? ????????? ????????? ??????
		//memberOk(); ?????? ?????? ????????? 
		return false; // jQuery?????? return false??? ???????????? ???????????? ???. return ?????? ?????????.. ??? ?????? ?????? ???????????? ???????????? ??????
	});
	
});

$(function() {
	$(".estimate_list_prebutton").click(function() {
		if ($(".estimate_list_controller").first().is(":visible")) { // ???????????? ????????? ?????????
			$(".estimate_list_controller:first").show();
		}
		
		$(".estimate_list_controller:visible").hide().prev(".estimate_list_controller").fadeIn(100);
		$(".estimate_list_button").removeClass("last");
					
	});
});


</script>

<section>
    <div class="estimate_banner">
        <div class="estimate_banner_controller">
            <h1 class="estimate_banner_content">??????????????? ??????????????? ? <span> ????????????</span> ?????? ?????? ?????? ?????? .</h1>
            <p class="estimate_banner_content_sub">??? ?????? ???????????? ?????? ??????-????????????-??????????????? ONE-STOP?????? !</p>
            <div class="estimate_banner_sendbutton">
                <button class="estimate_banner_sendbutton_button" type="button">?????? ????????????</button>
                
                <form name="estimate_list" method="post">
	                <div class="estimate_list_box">
	                    <div class="estimate_list_controller" style="display: none;">
	                        <div class="estimate_list_ingbar">
	                            <div class="estimate_list_ingbar_ing" style="width: 20%;"></div>
	                            <div class="estimate_list_ingbar_non" style="width: 80%;"></div>
	                        </div>
	                       <!-- ??? ?????? ????????? -->
	                        <div class="estimate_list_ingbar_text">
	                            <p style="margin-left: 15%;">1/5</p>
	                        </div>
	                        <h1 class="estimate_list_h1">?????? ????????? ???????????? ??????????????? ?</h1>
	                        <div class="estimate_list_content">
	                            <input name="homeName" type="radio" class="estimate_list_content_check"><span>?????????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="homeName" type="radio" class="estimate_list_content_check"><span>??????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="homeName" type="radio" class="estimate_list_content_check"><span>??????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="homeName" type="radio" class="estimate_list_content_check"><span>??????</span>
	                        </div>
	                        <div class="estimate_list_buttonbox">
	                        	<button type="button" class="estimate_list_prebutton"> ?????? </button>
	                            <button type="button" class="estimate_list_button" disabled="disabled"> ?????? </button>
	                        </div>
	                    </div>
	                    <!-- 2 ?????? ????????? -->
	                    <div class="estimate_list_controller" style="display: none;">
	                        <div class="estimate_list_ingbar">
	                            <div class="estimate_list_ingbar_ing" style="width: 40%;"></div>
	                            <div class="estimate_list_ingbar_non" style="width: 60%;"></div>
	                        </div>
	                        <div class="estimate_list_ingbar_text">
	                            <p style="margin-left: 35%;">2/5</p>
	                        </div>
	                        <h1 class="estimate_list_h1">?????? ???????????? ??????????????? ?</h1>
	                        <div class="estimate_list_content">
	                            <input name="bir" type="radio" class="estimate_list_content_check"><span>??????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="bir" type="radio" class="estimate_list_content_check"><span>1?????? ??????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="bir" type="radio" class="estimate_list_content_check"><span>2?????? ??????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="bir" type="radio" class="estimate_list_content_check"><span>2?????? ??????</span>
	                        </div>
	                        <div class="estimate_list_buttonbox">
	                            <button type="button" class="estimate_list_prebutton"> ?????? </button>
	                            <button type="button" class="estimate_list_button" disabled="disabled"> ?????? </button>
	                        </div>
	                    </div>
	                    
	                    <!-- 3 ?????? ????????? -->
	
	                    <div class="estimate_list_controller" style="display: none;">
	                        <div class="estimate_list_ingbar">
	                            <div class="estimate_list_ingbar_ing" style="width: 60%;"></div>
	                            <div class="estimate_list_ingbar_non" style="width: 40%;"></div>
	                        </div>
	                        <div class="estimate_list_ingbar_text">
	                            <p style="margin-left: 55%;">3/5</p>
	                        </div>
	                        <h1 class="estimate_list_h1">???????????? ????????? ??????????????? .</h1>
	                        <div class="estimate_list_content">
	                            <input name="budget" type="radio" class="estimate_list_content_check"><span>1????????????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="budget" type="radio" class="estimate_list_content_check"><span>2????????????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="budget" type="radio" class="estimate_list_content_check"><span>3????????????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="budget" type="radio" class="estimate_list_content_check"><span>4???????????? ??????</span>
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="budget" type="radio" class="estimate_list_content_check"><span>??????</span>
	                        </div>
	                        <div class="estimate_list_buttonbox">
	                            <button type="button" class="estimate_list_prebutton"> ?????? </button>
	                            <button type="button" class="estimate_list_button" disabled="disabled"> ?????? </button>
	                        </div>
	                    </div>
	
	                    <!-- 4 ?????? ????????? -->
	
	                    <div class="estimate_list_controller" style="display: none;">
	                        <div class="estimate_list_ingbar">
	                            <div class="estimate_list_ingbar_ing" style="width: 80%;"></div>
	                            <div class="estimate_list_ingbar_non" style="width: 20%;"></div>
	                        </div>
	                        <div class="estimate_list_ingbar_text">
	                            <p style="margin-left: 75%;">4/5</p>
	                        </div>
	                        <h1 class="estimate_list_h1">?????? ???????????? ?????? ??????????????? .</h1>
	                        <div class="estimate_list_content_memobox">
	                            <textarea name="content" class="estimate_list_content_memo content_memo"></textarea>
	                        </div>
	                        <div class="estimate_list_buttonbox">
	                            <button type="button" class="estimate_list_prebutton"> ?????? </button>
	                            <button type="button" class="estimate_list_button" > ?????? </button>
	                        </div>
	                    </div>
	
	                    <!-- 5 ?????? ????????? -->
	
	                    <div class="estimate_list_controller" style="display: none;">
	                        <div class="estimate_list_ingbar">
	                            <div class="estimate_list_ingbar_ing" style="width: 99%;"></div>
	                            <div class="estimate_list_ingbar_non" style="width: 1%;"></div>
	                        </div>
	                        <div class="estimate_list_ingbar_text">
	                            <p style="margin-left: 95%;">5/5</p>
	                        </div>
	                        <h1 class="estimate_list_h1">????????? ???????????? ??????????????? .</h1>
	                        <div class="estimate_list_content">
	                            <input name="userName" class="estimate_list_content_input estimate_input_name" type="text" placeholder="????????? ??????????????????.">
	                        </div>
	                        <div class="estimate_list_content">
	                            <input name="tel" class="estimate_list_content_input estimate_input_tel" type="text" placeholder="ex:) 010-1234-5678 ">
	                        </div>
	
	                        <div class="estimate_list_buttonbox">
	                            <button type="button" class="estimate_list_prebutton"> ?????? </button>
	                            <button type="button" class="estimate_list_button " disabled="disabled" onclick="javascript:location.href='${pageContext.request.contextPath}/itEstimate/main'"> ?????? </button>
	                        </div>
	                    </div>                    
	
	
	                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="estimate_sogae_box">
        <div class="estimate_sogae">
            <div class="estimate_sogae_items_box">
                <div class="estimate_sogae_item_imgbox">
                    <img src="${pageContext.request.contextPath}/resources/images/interior/sogae1.png">
                </div>
                <div class="estimate_sogae_item_contentbox">
                    <p>????????? ??????, ????????? ????????? ?????????????????? ?</p>
                    <p id="contentbox_sub_p">?????? ??????????????? ??? ??????, ????????? ?????? ??????<br>???????????? ????????? ???????????? ??????????????? </p>
                </div>
            </div>
            <div class="estimate_sogae_items_box">
                <div class="estimate_sogae_item_imgbox">
                    <img src="${pageContext.request.contextPath}/resources/images/interior/sogae2.png">
                </div>
                <div class="estimate_sogae_item_contentbox">
                    <p>????????? ????????? ?????? ???????????? ?????????????</p>
                    <p id="contentbox_sub_p">?????? ???????????? ????????? ????????????<br>???????????? ???????????? ??????????????? ?????????????????????.</p>
                </div>
            </div>
            <div class="estimate_sogae_items_box">
                <div class="estimate_sogae_item_imgbox">
                    <img src="${pageContext.request.contextPath}/resources/images/interior/sogae3.png">
                </div>
                <div class="estimate_sogae_item_contentbox">
                    <p>??? ????????? ?????? ????????? ????????? ?????????????</p>
                    <p id="contentbox_sub_p">?????? ???????????? ????????? ????????? ????????????<br>???????????? ???????????? ???????????? ??? ????????????. </p>
                </div>
            </div>
        </div>
        <div class="estimate_jin">
        </div>
    </div>

</section>