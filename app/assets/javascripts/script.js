$(function(){
  $('#reset-button').on('click', function(){
    B = document.getElementsByName('tea_type[]')
    $('#submit-button').prop("disabled", true);
    for(let i = 0; i < B.length; i++){
          B[i].checked = false;
    }
  });
});

$(function(){
 let B = document.querySelectorAll(`input[type='checkbox'][name='tea_type[]']`);
 for (let target of B) {
	target.addEventListener('change', () => {
		isCheck()
  	});
  }
});

function isCheck(){
    let B = document.getElementsByName('tea_type[]');
    let count = 0;
    for (let i = 0; i < B.length; i++) {
        if (B[i].checked) {
            count++;
        }
    }
    if (count > 0){
        $('#submit-button').prop("disabled", false);
    } else {
        $('#submit-button').prop("disabled", true);
    };
 
}