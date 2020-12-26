 String getOrderStatus({int statusId}) {
    switch (statusId) {
      case 10:
        return 'Pending';
      case 20:
        return 'Processing';
      case 30:
        return 'Complate';
      case 40:
        return 'Cancelled';
    }
    return '';
  }