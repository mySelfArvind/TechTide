//edit profile js
$(document).ready(function () {
    let editBtn = false;
    $('#EditBtn').on('click', function () {
        if (editBtn === false) {
//to fr display form bnd kro and edit form dikhao
            $('#profile-details').hide();
            $('#profile-edit').show();
            $('#EditBtn').html("Back");
            editBtn = true;
        } else {
//to fr edit form bnd kro and display form dikhao
            $('#profile-details').show();
            $('#profile-edit').hide();
            $('#EditBtn').html("Edit Profile");
            editBtn = false;
        }
    });
});

//add post servlet
$(document).ready(function () {
    $('#add-post-form').on('submit', function (event) {
        event.preventDefault();
        let formData = new FormData(this);
        $.ajax({
            url: 'AddPostServlet',
            data: formData,
            type: 'POST',
            success: function (data, textStatus, jqXHR) {
                if (data.trim() === 'Post Added Successfully') {
                    Swal.fire({
                        text: data,
                        icon: 'success'
                    });
                } else {
                    Swal.fire({
                        text: "Something Went Wrong",
                        icon: 'success'
                    });
                }
            }, error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
            },
            processData: false,
            contentType: false
        });
    });
});

