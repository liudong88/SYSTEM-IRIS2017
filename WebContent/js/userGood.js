/**
 *
 */
var userGoods = new Object();

// 画像を読み込むときは必ず実行
function setUserGood(photo_id, userGood) {
	userGoods[photo_id] = userGood;
}

// goodを送信
function sendGood(photo_id) {
	var tmpSignal;
	if(userGoods[photo_id] === "true") {
		userGoods[photo_id] = "false";
	} else {
		userGoods[photo_id] = "true";
	}
	if(userGoods[photo_id] === "true") {
		tmpSignal = 'good';
	} else {
		tmpSignal = 'cancel';
	}
	$.ajax({
		url: 'PhotoGoodServlet?photo_id='+photo_id+'&signal='+tmpSignal,
		type: 'GET'
	}).then(function() {
		var tmpGoodNum = $('a.goodPhotoID_'+photo_id).find('span').text();
		if(userGoods[photo_id] === "true") {
			tmpGoodNum++;
		} else {
			tmpGoodNum--;
		}
		$('a.goodPhotoID_'+photo_id).find('span').text(tmpGoodNum);
		$('a.goodPhotoID_'+photo_id).find('img').attr('src','./images/icon/heart_'+userGoods[photo_id]+'.png');
	}, function() {
		console.log('sendGood: error');
	});
}