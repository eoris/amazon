$(document).ready ->
  $('#shipping-checkbox').click () ->
    if @checked
      value1 = document.getElementById('billing_address_firstname').value;
      value2 = document.getElementById('billing_address_lastname').value;
      value3 = document.getElementById('billing_address_address').value;
      value4 = document.getElementById('billing_address_city').value;
      value5 = document.getElementById('billing_address_country_id').value;
      value6 = document.getElementById('billing_address_zipcode').value;
      value7 = document.getElementById('billing_address_phone').value;
    else
      value1 = ''; value2 = ''; value3 = ''; value4 = ''; value5 = ''; value6 = ''; value7 = '';
    document.getElementById('shipping_address_firstname').value = value1;
    document.getElementById('shipping_address_lastname').value = value2;
    document.getElementById('shipping_address_address').value = value3;
    document.getElementById('shipping_address_city').value = value4;
    document.getElementById('shipping_address_country_id').value = value5;
    document.getElementById('shipping_address_zipcode').value = value6;
    document.getElementById('shipping_address_phone').value = value7;
