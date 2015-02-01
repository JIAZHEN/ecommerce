(function() {
  $(window).load(function() {
    $('a[data-target]').click(function(e) {
      var $this, new_target, qty_value, url;
      e.preventDefault();
      $this = $(this);
      if ($this.data('target') === 'Add to') {
        url = $this.data('addurl');
        new_target = "Remove from";
      } else {
        url = $this.data('removeurl');
        new_target = "Add to";
      }
      qty_value = $('#qty_selector .qty').val();
      return $.ajax({
        url: url,
        type: 'put',
        data: {
          qty: qty_value
        },
        success: function(data) {
          $('.cart-count').html(data["count"]);
          $this.find('span').html(new_target);
          return $this.data('target', new_target);
        }
      });
    });
    return $('#cart a').click(function(e) {
      var $this, product_id, url;
      e.preventDefault();
      $this = $(this);
      url = $this.data('removeurl');
      product_id = $this.data('product_id');
      return $.ajax({
        url: url,
        type: 'put',
        success: function(data) {
          $('.cart-count').html(data["count"]);
          $("tr[id='" + product_id + "']").remove();
          return $(".simpleCart_grandTotal").html(data["total"]);
        }
      });
    });
  });

}).call(this);
