$(document).ready(function(){

    let category_id;
    let name;
    let location;

    $("h4#total-results").hide();
    $("span#business-links").hide();

    const checkLength = (data) => {
        let text;
        text = data.length > 1 ? "results" : "result";
        return text;
    };

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

    const setVariables = () => {
        let location_input = $(".form-control.location-input").val();
        location = location_input === null ? "" : location_input;
        let category_input = $(".form-control.category-input").val() ;
        category_id = category_input === null ? "" : category_input;

    };

    const afterSearch = (name, category_id, location) => {
        searchBusiness(name, category_id, location)
            .then(data => {
                setText(data);
                resetView(name, category_id, location)
            });
    };

    $('#business_name_search').keyup(event => {
        setVariables();
        name = event.currentTarget.value;
        console.log(name, location, category_id);
        afterSearch(name, category_id, location)

    });

    $('.form-control.location-input').change(event => {
        name = name === undefined ? '' : name;
        category_id = category_id === undefined ? '' : category_id;
        location = event.currentTarget.value;
        afterSearch(name, category_id, location)

    });


    $(".form-control.category-input").change(event => {
        name = name === undefined ? '' : name;
        location = location === undefined ? '' : location;
        category_id = event.currentTarget.value;
        afterSearch(name, category_id, location)

    });


    const setText = (data) => {
        if(data.length === 0){
            $("h4.font-italic.text-light").text("No search results found");
            $("h4#total-results:hidden").show();
            $("span#business-links").hide();
        } else {
            const totalResults = data.length;
            $("h4.font-italic.text-light").text(`${totalResults} search ${checkLength(data)} found`);
            $("h4#total-results:hidden").show();
            let links = $.map(data, (business) =>
                $("<a></a>").attr("href", `/businesses/${business.id}/profile`).text(`${business.business_name}`).addClass("business-link")
            );
            setLinks(links)
        }
    };

    const setLinks = (links) => {
        const business_links =  $("span#business-links:hidden");
        const business_link = $(".business-link");
        if (business_link.length === 0) {
            business_links.append(links);
            business_links.show();
            return links.pop();
        } else {
            business_link.remove();
            business_links.append(links);
            business_links.show();
            return links.pop();
        }
    };

    const resetView = (name, category_id, location) => {
        if (name === "" && category_id === "" && location === "") {
            $("h4#total-results").hide();
            return $("span#business-links").hide();
        }
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

    const searchBusiness = (name, category_id, location) => {
        return $.ajax({
            url: `/businesses_search?has_name=${name}&belongs_to_category=${category_id}&in_location=${location}`,
            type: 'GET',
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