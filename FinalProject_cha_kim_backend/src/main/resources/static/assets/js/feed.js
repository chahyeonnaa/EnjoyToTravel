function like(element) {
    var likeCount = element.parentNode.querySelector(".like-count");
    likeCount.textContent = parseInt(likeCount.textContent) + 1;
}

function showComments(feedId) {
    var modal = new bootstrap.Modal(document.getElementById("commentModal_" + feedId));
    modal.show();
}

function updateCommentCount(feedId, count) {
    var commentCount = document.querySelector(`#comment-count_${feedId}`);
    if (commentCount) {
        commentCount.textContent = count;
    }
}

function addComment(feedId) {
    var commentInput = document.querySelector("#commentInput_" + feedId).value;
    var commentList = document.querySelector("#commentList_" + feedId);
    var li = document.createElement("li");
    li.textContent = commentInput;
    commentList.appendChild(li);
    document.querySelector("#commentInput_" + feedId).value = "";

    // Update comment count
    var comments = commentList.querySelectorAll("li");
    updateCommentCount(feedId, comments.length); // 댓글 수 업데이트
}

var feeds = [];

function addFeed() {
    var feedTitle = document.getElementById("feedTitle").value;
    var feedContent = document.getElementById("feedContent").value;
    var feedImage = document.getElementById("feedImage").value;

    var newFeed = {
        id: "feed" + feeds.length,
        title: feedTitle,
        content: feedContent,
        image: feedImage,
        comments: []
    };

    feeds.push(newFeed);
    renderFeed(newFeed);
    clearInputFields();
}

function renderFeed(feed) {
    var feedContainer = document.getElementById("feedContainer");
    var card = document.createElement("div");
    card.classList.add("card", "mb-4");
    image = "../img/noimgs.png"
    if (feed.image !== "") {
        image = feed.image;
    }
     
    card.innerHTML = `
        <img src="${image}" class="card-img-top" alt="...">
        <div class="card-body">
            <h5 class="card-title">${feed.title}</h5>
            <p class="card-text">${feed.content}</p>
            <img src="../img/like.png" alt="Like" class="like-btn" onclick="like(this)">
            <span class="like-count">0</span>
            <img src="../img/comment.png" alt="Comment" class="comment-btn" onclick="showComments('${feed.id}')">
            <span id="comment-count_${feed.id}" class="comment-count">0</span> <!-- 댓글 수를 나타내는 요소 -->
        </div>
    `;
    feedContainer.prepend(card);

    // 각 피드에 대한 모달 생성 및 추가
    var commentModal = document.createElement("div");
    commentModal.innerHTML = `
        <div class="modal fade" id="commentModal_${feed.id}" data-bs-backdrop="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Comments</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <ul id="commentList_${feed.id}">
                            <!-- Comments will be dynamically added here -->
                        </ul>
                        <textarea id="commentInput_${feed.id}" class="form-control mt-3" placeholder="Write a comment..." rows="4"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="addComment('${feed.id}')">Add Comment</button>
                    </div>
                </div>
            </div>
        </div>
    `;
    document.body.appendChild(commentModal);
}

function clearInputFields() {
    document.getElementById("feedTitle").value = "";
    document.getElementById("feedContent").value = "";
    document.getElementById("feedImage").value = "";
}



