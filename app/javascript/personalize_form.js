document.addEventListener("DOMContentLoaded", function() {
  const personalizeForm = document.getElementById("personalize_form");
  const loadingModal = document.getElementById("loading_modal");

  if (personalizeForm) {
    personalizeForm.addEventListener("submit", function(event) {
      // 新しいモーダルを表示
      if (loadingModal) {
        loadingModal.showModal();
      }

      // フォーム送信を非同期に処理
      event.preventDefault();

      const formData = new FormData(personalizeForm);
      fetch(personalizeForm.action, {
        method: "POST",
        body: formData,
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
          "Accept": "application/json"
        }
      })
      .then(response => response.json())
      .then(data => {
        if (data.redirect_url) {
          window.location.href = data.redirect_url;
        } else {
          // エラーハンドリング
          if (loadingModal) {
            loadingModal.close();
          }
          alert(data.error);
        }
      })
      .catch(error => {
        console.error("Error:", error);
        if (loadingModal) {
          loadingModal.close();
        }
      });
    });
  }
});