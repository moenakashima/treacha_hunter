
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
 
};

window.onload = function() {
  (function() {
    var print_img_id = 'print_img';
    if (checkFileApi()) {
      var file_image = document.getElementById('file-image');
      file_image.addEventListener('change', selectReadfile, false);
    }
    function checkFileApi() {
      if (window.File && window.FileReader && window.FileList && window.Blob) {
        return true;
      }
      alert('このブラウザはFile APIに対応していないため利用できません');
      return false;
    }
    function selectReadfile(e) {
      var file = e.target.files;
      var reader = new FileReader();
      reader.readAsDataURL(file[0]);
      reader.onload = function() {
        readImage(reader, print_img_id);
      }
    }
    function readImage(reader, print_image_id) {
      var result_DataURL = reader.result;
      var img = document.getElementById(print_image_id);
      var src = document.createAttribute('src');
      src.value = result_DataURL;
      img.setAttributeNode(src);
    }
  })();
}