from src.regions.region import Region
from src.type_of_node import TypeNode


def add_parent_and_child(before_r, next_r, region, pred_child, pred_parent):
    for i in list(range(0, len(before_r))):
        index = before_r[i].children.index(pred_child[i])
        before_r[i].children[index] = region
        region.add_parent(before_r[i])
    if next_r is not None:
        index = next_r.parent.index(pred_parent)
        next_r.parent[index] = region
        region.add_child(next_r)


def check_if(curr_region):
    if curr_region.type == TypeNode.basic and len(curr_region.children) == 2 \
            and (len(curr_region.children[0].children) > 0
                 and curr_region.children[0].children[0] == curr_region.children[1]
                 or len(curr_region.children[1].children) > 0
                 and curr_region.children[1].children[0] == curr_region.children[0]):
        return True
    else:
        return False


def check_if_else(curr_region):
    if curr_region.type == TypeNode.basic and len(curr_region.children) == 2 \
            and len(curr_region.children[0].children) > 0 \
            and len(curr_region.children[1].children) > 0 \
            and curr_region.children[0].children[0] == curr_region.children[1].children[0]:
        return True
    else:
        return False


def create_new_region(prev_reg_1, prev_reg_2, next_reg):
    prev_reg_1.children.remove(next_reg)
    prev_reg_2.children.remove(next_reg)
    position = next_reg.parent.index(prev_reg_1)
    new_fiction_region = Region(TypeNode.linear, next_reg.start)
    next_reg.parent[position] = new_fiction_region
    next_reg.parent.remove(prev_reg_2)
    prev_reg_1.children.append(new_fiction_region)
    prev_reg_2.children.append(new_fiction_region)
    new_fiction_region.parent.append(prev_reg_1)
    new_fiction_region.parent.append(prev_reg_2)
    new_fiction_region.children.append(next_reg)
    return new_fiction_region


def join_regions(before_region, curr_region, next_region, start_region):
    start_now = start_region
    if len(before_region) == 1:
        before_region = before_region[0]
        if before_region.type != TypeNode.basic:
            region = Region(TypeNode.linear, before_region)
            region.end = curr_region
            if before_region == start_now:
                start_now = region
            else:
                parent = before_region.parent[0]
                index = parent.children.index(before_region)
                parent.children[index] = region
                region.add_parent(parent)
            if next_region is not None:
                index = next_region.parent.index(curr_region)
                next_region.parent[index] = region
                region.add_child(next_region)
            if next_region is not None and next_region.type != TypeNode.basic and len(curr_region.parent) == 1:
                region_all = Region(TypeNode.linear, before_region)
                region_all.end = next_region
                if start_now == region:
                    start_now = region_all
                else:
                    parent = before_region.parent[0]
                    index = parent.children.index(region)
                    parent.children[index] = region_all
                    region_all.add_parent(parent)
                if next_region.children:
                    child = next_region.children[0]
                    index = child.parent.index(next_region)
                    child.parent[index] = region_all
                    region_all.add_child(child)
            return start_now

    if next_region is not None and next_region != TypeNode.basic and len(curr_region.parent) == 1:
        region_all = Region(TypeNode.linear, curr_region)
        region_all.end = next_region
        for prev_r in before_region:
            index = prev_r.children.index(curr_region)
            prev_r.children[index] = region_all
            region_all.add_parent(prev_r)
        if next_region.children:
            child = next_region.children[0]
            index = child.parent.index(next_region)
            child.parent[index] = region_all
            region_all.add_child(child)
    return start_region
