function openModal(user,photo_id){
   
    var input_html = '<input type="hidden" id="id_input" name="photo_id" value='+photo_id+'>';
    
    console.log('activate');
    //キーボード操作などにより、オーバーレイが多重起動するのを防止する
    $(this).blur() ;	//ボタンからフォーカスを外す
    if($("#modal-overlay")[0]) return false ; //新しくモーダルウィンドウを起動しない [下とどちらか選択]

    //オーバーレイ用のHTMLコードを、[body]内の最後に生成する
    $("body").append('<div id="modal-overlay"></div>');

    //[$modal-overlay]をフェードインさせる
    $("#modal-overlay").fadeIn("slow");
    $("#comment-modal").fadeIn("slow");

    $("#com-form").append(input_html);

}

$(document).unbind().on('click',"#modal-overlay,#modal-close",
    function(){
        console.log('delete');
        $("#comment-modal,#modal-overlay").fadeOut("fast",function(){
        //フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
            $("#modal-overlay").remove();
            $("#id_input").remove();
        });
    }
);