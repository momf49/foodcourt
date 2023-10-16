// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MetaEarth FoodCourt {
    struct Menuitem {
        uint256 id;
        string name;
        string country;
        uint256 price;
    }

    struct Staff {
        uint256 id;
        string name;
        string role;
    }

    struct Table {
        uint256 id;
        uint256 capacity;
        bool isOccupied;
    }

    struct Order {
        uint256 orderId;
        address customer;
        uint256[] menutItemIds;
        uint256 tableId;
        bool isComplete;
    }

    mapping(uint256 => MenuItem) public menuItems;
    mapping(uint256 => Staff) public staffMembers;
    mapping(uint256 => Table) public tables;
    mapping(uint256 => Order) public orders;

    uint256 public nextMenuItemId;
    uint256 public nextStaffId;
    uint256 public nextTableId;
    uint256 public nextOrderId;

    event MenuItemAdded(uint256 id, string name, string country, uint256 price);
    event StaffMemberAdded(uint256 id, string name, string role);
    event TableAdded(uint256 id, uint256 capacity);
    event TableOccupied(uint256 tableId, address customer);
    event TableReleased(uint256 tableId);
    event OrderPlaced(uint256 orderId, address customer, uint256[] menuItemId, uint256 tableId);
    event OrderCompleted(uint256 orderId);

    constructor() {
        nextMenuItemId = 1;
        nextStaffId = 1;
        nextTableId = 1;
        nextOrderId = 1;
    }

    function addMenuItem(string memory name, string memory country, uint256 price) public {
        menuItems[nextMenuItemId] = MenuItem(nextMenuItemId, name, country, price);
        emit MenuItemAdded(nextMenuItemId, name, country, price);
        nextMenuItemId++;
    }

    function addStaffMembers(string memory name, string memory role) public {
        staffMembers[nexStaffId] = Staff(nextStaffId, name, role);
        emit StaffMemberAdded(nextStaffId, name, role);
        nextStaffId++;
    }

    function addTable(uint256 capacity) public {
        tables[nextTableId] = Table(nextTableId, capacity, false);
        emit TableAdded(nextTableId, capacity);
        nextTableId++;
    }

    function occupyTable(uint256 tableId) public {
        require(tables[tableId].id !=0, "Table does not exist");
        require(!tables[tableId].isOccupied, "Table is already occupied");

        tables[tableId].isOccupied = true;
        emit TableOccupied(tableId, msg.sender);
    }

    function releaseTable(uint256 tableId) public {
        require(tables[tableId].id !=0, "Table does not exist");
        require(tables[tableId].isOccupied, "Table is not occupied");

        tables[tableId].isOccupied = false;
        emit TableReleased(tableId);
    }

    function placeOrder(uint256[] memory menuItemId, uint256 tableId) public {
        require(menuItemIds.length > 0, "Empty order is not allowed");
        require(tables[tableId].id !=0, "Table does not exist");
        require(tables[tableId].isOccupied, "Table is not occupied");

        orders[nextOrderId] = Order(nextOrderId, msg.sender, menuItemId, tableId, false);
        emit OrderPlaced(nextOrderId, msg.sender, menuItemId, tableId);
        nextOrder++;
    }

    function completeOrder(uint256 orderId) public {
        require(orders[orderId].orderId !=0, "Order does not exist");
        require(orders[orderId].isComplete == false, "Order is already completed");

        orders[orderId].isComplete = true;
        emit OrderCompleted(orderId);
    }

    function getMenuItems() public view returns (MenuItem[] memory) {
        MenuItem[] memory items = new MenuItem[](nextMenuItemId - 1);
        for (uint256 i = 1; i < nextMenuItemId; i++) {
            items[i - 1] = menuItems[i];
        }
        return items;
    }

    function getStaffMembers() public view returns (Staff[] memory) {
        Staff[] memory members = new Staff[](nextStaffId - 1);
        for (uint256 i = 1; i < nextStaffId; i++) {
            members[i - 1] = staffMembers[i];
        }
        returns members;
    }

    function getTables() public view returns (Table[] memory) {
        Table[] memory tableList = new Table[](nextTableId - 1);
        for (uint256 i = 1; i < nextTableId; i++) {
            tableList[i - 1] = tables[i];
        }
        return tableList;
    }

    function getOrders() public view returns (Order[] memory) {
        Order[] memory orderList = new Order[](nextOrderId - 1);
        for (uint256 i = 1; i < nextOrderId; i++) {
            orderList[i - 1] = orders[i];
        }
        return orderList;
    }

    function getOrderDetails(uint256 orderId) public view returns (Order memory) {
        require(orders[orderId].orderId !=0, "Order does not exist");
        return orders[orderId];
    }
}