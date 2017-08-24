/**
 * 実行例) href="javascript:getDetails(画像ID);"
 */
function getDetails(id) {
	$.ajax({
		url: './js/samplePhotoDetails.json?photo_id=' + id,
		type: 'GET',
		datatype: 'json'
	}).then(function(json) {
		var data = json.photo[0];
		openModal(data);
	}, function(json) {
		console.log('getDetails: error');
	});
}
function openModal(data) {
	var HTML = '';
	//--img--
	HTML += '<div id="photoInfo">';
	HTML += '<div id="photoImage"><img src="'+data.path+'" style="width:100%;"></div>';
	//--info--
	HTML += '<ul>';
	HTML += '<li style="display:block;padding:0;color:#ccc;">'+data.user+'</li>';
	HTML += '<li style="display:block;margin:0 5px 0 1em;background-color:#9bffd9;">'+data.explanation+'</li>';
	HTML += '<li style="display:block;padding:0;text-align:right;font-weight:normal;color:#ccc;">'+data.time+'</li>';
	HTML += '<li><a class="goodButton goodPhotoID_'+data.photo_id+'" href="javascript:sendGood('+data.photo_id+');"><img src="./images/icon/heart_'+data.user_good+'.png"> <span>'+data.good_cnt+'</span></a></li>';
	HTML += '<li><img src="./images/icon/comment.png"> '+data.com_cnt+'件</li>';
	HTML += '</ul>';
	//--comment--
	HTML += '<div id="photoComments">';
	HTML += '<ul>';
	for(var i = 0; i < data.com_cnt; i++) {
		HTML += '<li>';
		HTML += '<ul>';
		HTML += '<li>'+data.comments[i].com_name+'</li>';
		HTML += '<li style="color:#0015b2;margin:0 0 0 2em;padding:10px;background-color:#9bffd9;">'+data.comments[i].comment+'</li>';
		HTML += '<li style="text-align:right;">'+data.comments[i].com_time+'</li>';
		HTML += '</ul>';
		HTML += '</li>';
	}
	HTML += '</ul>';
	HTML += '</div>';
	HTML += '</div>';

	$('div#modalWindow > div#modalContent').html(HTML);
	$('body').css({overflow: 'hidden'});
	$('div#modalWindow').fadeIn('fast', function() {
	});
	$('div#modalHeader').css({height: $('div#modalHeader > a').outerHeight() + 'px'});
}
function closeModal() {
	$('div#modalWindow').fadeOut('fast');
	$('body').css({overflow: 'auto'});
}
