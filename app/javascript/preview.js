if (document.URL.match( /items/ )) {
  document.addEventListener('DOMContentLoaded', () => {
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {
      // 親要素生成
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class','image-element');
      let imageElementNum = document.querySelectorAll('.image-element').length;
      imageElement.setAttribute('id', `image_element_${imageElementNum}`);
      // 画像生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      // ボタン生成
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `item_image_${imageElementNum}`);
      inputHTML.setAttribute('name', 'item[images][]');
      inputHTML.setAttribute('type', 'file');

      let imageNum = document.images.length - 2;

      console.log(`要素${imageElementNum}`);
      console.log(`画像${imageNum}`);
      console.log(document.getElementById(`image_element_0`));
      console.log(document.getElementById(`image_0`) == null );

      if (imageElementNum == imageNum){
        blobImage.setAttribute('id', `image_${imageElementNum}`);
        inputHTML.setAttribute('id', `item_image_${imageElementNum}`);
        imageElement.appendChild(blobImage);
        imageElement.appendChild(inputHTML);
        ImageList.appendChild(imageElement);
      }else{
        for (let i = 0; i <= imageElementNum; i++){
          if(document.getElementById(`image_${i}`) == null){
            const insertElement = document.getElementById(`image_element_${i}`)
            blobImage.setAttribute('id', `image_${i}`);
            insertElement.insertBefore(blobImage,insertElement.firstChild);
            return;
          }
        }
      }

      inputHTML.addEventListener('change', (e) => {
        const imgNum = document.querySelectorAll('.image-element').length;
        if (imgNum >= imageElementNum + 1){
         const imageContent = document.getElementById(`image_${imageElementNum + 1}`);
          if (imageContent){
            imageContent.remove();
          }
        }
        const file = e.target.files[0];
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      });
    };


    // 最初のボタン
    document.getElementById('item-image').addEventListener('change', (e) => {
      // 画像があれば削除
      const imageContent = document.getElementById('image_0');

      if (imageContent){
        imageContent.remove();
      }
      // URL生成
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
};