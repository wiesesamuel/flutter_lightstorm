class Entity {
  List<int> group;

  void addGroup(int group) {
    if (!this.group.contains(group))
      this.group.add(group);
  }

  void rmGroup(int group) {
    if (this.group.contains(group))
      this.group.remove(group);
  }

  bool isGroup(int group) => this.group.contains(group);
}