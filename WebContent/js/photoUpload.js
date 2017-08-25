/**
 *
 */
$(function(){
    var setFileInput = $('.imgInput');

    setFileInput.each(function(){
        var selfFile = $(this),
        selfInput = $(this).find('input[type=file]');

        selfInput.change(function(){
            var file = $(this).prop('files')[0],
            fileRdr = new FileReader(),
            selfImg = selfFile.find('.imgView');

            if(!this.files.length){
                if(0 < selfImg.size()){
                    selfImg.remove();
                    $('#sbbutton').css("background-color","#303030").prop("disabled", true);
                    return;
                }
            } else {
                if(file.type.match('image.*')){
                    if(!(0 < selfImg.size())){
                        selfFile.append('<p class="imgView">写真プレビュー</p><img alt="" class="imgView">');
                        $('#sbbutton').css("background-color","#85e249").prop("disabled", false);
                    }
                    var prevElm = selfFile.find('.imgView');
                    fileRdr.onload = function() {
                        prevElm.attr('src', fileRdr.result);
                    }
                    fileRdr.readAsDataURL(file);
                } else {
                    if(0 < selfImg.size()){
                        selfImg.remove();
                        $('#sbbutton').css("background-color","#303030").prop("disabled", true);
                        return;
                    }
                }
            }
        });
	});
});
/*
$('#filebutton').click(function(){
	// 現在地を取得
	navigator.geolocation.getCurrentPosition(
		// 取得成功した場合
		function(position) {
			$('#lat').attr('value',position.coords.latitude);
			$('#lng').attr('value',position.coords.longitude);
		},
	    // 取得失敗した場合
	    function(error) {
			switch(error.code) {
	        	case 1: //PERMISSION_DENIED
	        		alert("位置情報の利用が許可されていません");
	        		break;
	        	case 2: //POSITION_UNAVAILABLE
	        		alert("現在位置が取得できませんでした");
	        		break;
	        	case 3: //TIMEOUT
	        		alert("タイムアウトになりました");
	        		break;
	        	default:
	        		alert("その他のエラー(エラーコード:"+error.code+")");
	        		break;
	    	}
	    }
	);
});*/