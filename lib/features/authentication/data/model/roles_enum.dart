enum RolesEnum {
  owner,
  plantHead,
  supervisor,
  worker,
  distributor,
  customer,
  centralOffice,
}

extension RolesEnumToString on RolesEnum {
  String toApiString() {
    switch (this) {
      case RolesEnum.owner:
        return "OWNER";
      case RolesEnum.plantHead:
        return "PLANT_HEAD";
      case RolesEnum.supervisor:
        return "SUPERVISOR";
      case RolesEnum.worker:
        return "WORKER";
      case RolesEnum.distributor:
        return "DISTRIBUTOR";
      case RolesEnum.customer:
        return "CUSTOMER";
      case RolesEnum.centralOffice:
        return "CENTRAL_OFFICE";
    }
  }
}

extension StringToRolesEnum on String {
  RolesEnum toRoleEnum() {
    switch (toUpperCase()) {
      case "OWNER":
        return RolesEnum.owner;
      case "PLANT_HEAD":
        return RolesEnum.plantHead;
      case "SUPERVISOR":
        return RolesEnum.supervisor;
      case "WORKER":
        return RolesEnum.worker;
      case "DISTRIBUTOR":
        return RolesEnum.distributor;
      case "CUSTOMER":
        return RolesEnum.customer;
      case "CENTRAL_OFFICE":
        return RolesEnum.centralOffice;
      default:
        return RolesEnum.customer;
    }
  }
}
