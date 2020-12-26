enum NetworkRequestType {
  GET,
  GET_RAW,
  POST,
  POST_RAW,
  GET_AUTHORIZED,
  GET_RAW_AUTHORIZED,
  POST_AUTHORIZED,
  POST_RAW_AUTHORIZED,

  GET_JSON,
  GET_RAW_JSON,
  POST_JSON,
  POST_RAW_JSON,
  GET_AUTHORIZED_JSON,
  GET_RAW_AUTHORIZED_JSON,
  POST_AUTHORIZED_JSON,
  POST_RAW_AUTHORIZED_JSON,
}

extension NetworkRequestTypeExtensions on NetworkRequestType {
  bool isJson() {
    if (this == NetworkRequestType.GET_JSON ||
        this == NetworkRequestType.GET_AUTHORIZED_JSON ||
        this == NetworkRequestType.GET_RAW_AUTHORIZED_JSON ||
        this == NetworkRequestType.GET_RAW_JSON ||
        this == NetworkRequestType.POST_JSON ||
        this == NetworkRequestType.POST_RAW_JSON ||
        this == NetworkRequestType.POST_AUTHORIZED_JSON ||
        this == NetworkRequestType.POST_RAW_AUTHORIZED_JSON) {
      return true;
    }
    return false;
  }

  bool isAuthorized() {
    if (this == NetworkRequestType.GET_AUTHORIZED ||
        this == NetworkRequestType.GET_AUTHORIZED_JSON ||
        this == NetworkRequestType.GET_RAW_AUTHORIZED ||
        this == NetworkRequestType.GET_RAW_AUTHORIZED_JSON ||
        this == NetworkRequestType.POST_AUTHORIZED ||
        this == NetworkRequestType.POST_AUTHORIZED_JSON ||
        this == NetworkRequestType.POST_RAW_AUTHORIZED ||
        this == NetworkRequestType.POST_RAW_AUTHORIZED_JSON) {
      return true;
    }
    return false;
  }

  bool isPost() {
    if (this == NetworkRequestType.POST ||
        this == NetworkRequestType.POST_AUTHORIZED ||
        this == NetworkRequestType.POST_AUTHORIZED_JSON ||
        this == NetworkRequestType.POST_JSON) {
      return true;
    }
    return false;
  }

  bool isPostRaw() {
    if (this == NetworkRequestType.POST_RAW ||
        this == NetworkRequestType.POST_RAW_AUTHORIZED ||
        this == NetworkRequestType.POST_RAW_AUTHORIZED_JSON ||
        this == NetworkRequestType.POST_RAW_JSON) {
      return true;
    }
    return false;
  }
  bool isGet() {
    if (this == NetworkRequestType.GET ||
        this == NetworkRequestType.GET_AUTHORIZED ||
        this == NetworkRequestType.GET_AUTHORIZED_JSON ||
        this == NetworkRequestType.GET_JSON) {
      return true;
    }
    return false;
  }

  bool isGetRaw() {
    if (this == NetworkRequestType.GET_RAW ||
        this == NetworkRequestType.GET_RAW_AUTHORIZED ||
        this == NetworkRequestType.GET_RAW_AUTHORIZED_JSON ||
        this == NetworkRequestType.GET_RAW_JSON) {
      return true;
    }
    return false;
  }
}
