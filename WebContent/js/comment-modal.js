
function openModal(photo_id){

    var input_html = '<input type="hidden" id="id_input" name="photo_id" value='+photo_id+'>';

    //console.log('activate');
    //キーボード操作などにより、オーバーレイが多重起動するのを防止する
    $(this).blur() ;	//ボタンからフォーカスを外す
    if($("#modal-overlay")[0]) return false ; //新しくモーダルウィンドウを起動しない [下とどちらか選択]

    //オーバーレイ用のHTMLコードを、[body]内の最後に生成する
    $("body").append('<div id="modal-overlay"></div>');

    //[$modal-overlay]をフェードインさせる
    $("#modal-overlay").fadeIn("slow");
    $("#comment-modal").fadeIn("slow");

    $("#com-form").append(input_html);
    $("#dest-user").html(user+'の画像へコメント');
}

$(document).unbind().on('click',"#modal-overlay,#modal-close",
    function(){
        //console.log('delete');
        $("#comment-modal,#modal-overlay").fadeOut("fast",function(){
        //フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
            $("#modal-overlay").remove();
            $("#id_input").remove();
        });
    }
);

$(document).on("submit","#com-form",function(evt){
    evt.preventDefault();
    console.log('confirm');

    if(window.confirm('コメントを投稿しますか?')){
        $.ajax({
            url:$('#com-form').attr('action'),
            type:$('#com-form').attr('method'),
        }).then(
            function(){
                console.log('success');
                alert('投稿が完了しました!');
                console.log('delete');
                $("#comment-modal,#modal-overlay").fadeOut("slow",function(){
                //フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
                    $("#modal-overlay").remove();
                    $("#id_input").remove();
                });
            },
            function(){
                console.log('failed');
            }
        )
     }
 })