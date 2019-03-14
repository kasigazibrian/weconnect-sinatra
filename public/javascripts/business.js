$(document).ready(function(){

    const deleteBusiness = function(businessId) {
        return $.ajax({
            url: `/businesses/${businessId}/delete`,
            type: 'DELETE',
            done: (response) => {
                return response;
            },
            fail: (error) => {
                return error;
            }
        });
    };

    const editBusiness = function(businessId, business) {
        return $.ajax({
            url: `/businesses/${businessId}/edit`,
            type: 'PUT',
            data: business,
            done: (response) => {
                return response;
            },
            fail: (error) => {
                return error;
            }
        });
    };

    $(".confirmDeleteBusiness").click(event => {
        event.preventDefault();
        const business_id = ($(event.currentTarget).attr('id'));
        deleteBusiness(business_id)
            .then(response => {
                window.location.href = "/businesses";

            })
            .fail (error => {
                window.location.href = "/businesses";
        })

    });

    $("#edit_business").click(event => {
        event.preventDefault();
        const business_id = ($(event.currentTarget).attr('data-business-id'));
        const dataArray = $('#edit-business-form').serializeArray();
        const getFormData = (dataArray) => {
            let data = {};
            for(let i=0; i<dataArray.length; i++){
                data[dataArray[i].name] = dataArray[i].value;
            }
            return data
        };
        const data = getFormData(dataArray);
        editBusiness(business_id, data)
            .then(response => {
                window.location.href = `/businesses/${business_id}/profile`;

            })
            .fail (error => {
                window.location.href = `/businesses/${business_id}/edit`;
            })

    })

});