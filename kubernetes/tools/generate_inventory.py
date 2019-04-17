import json
import os


def find_state_files():
    root = os.getcwd()
    for dir_path, _, file_names in os.walk(root):
        for name in file_names:
            suffix = os.path.splitext(name)[-1]
            if suffix == ".tfstate":
                yield os.path.join(dir_path, name)

def build_resource_iter_from_files(file_names):
    for file_name in file_names:
        with open(file_name, 'r') as json_file:
            state = json.load(json_file)
            return build_resource_iter(state)

def build_resource_iter(state):
    for mod in state["modules"]:
        name = mod["path"][-1]
        print(name)
        for key, resource in mod["resources"].items():
            yield name, key, resource

def resource_parser_iter(resources):
    for module_name, key, resource in resources:
        resource_type, name = key.split('.', 1)
        if resource_type == "exoscale_compute":
            parse_exoscale_resource(resource)
            # yield parse_exoscale_resource(resource)

def parse_exoscale_resource(resource):
    resource_attributes = resource["primary"]["attributes"]
    name = resource_attributes.get("name")
    print(name)
    print(resource_attributes["ip_address"])
    print(resource_attributes)
    # meta_data = parse_dict(resource_attributes, "metadata")
    #groups = ['etcd', 'master', 'node']
    #attrs = {
    #    'metadata': meta_data,
    #    'ansible_ssh_port': meta_data.get('ssh_port', 22),
    #    'ansible_ssh_user': meta_data.get('ssh_user', 'root'),
    #    'ansible_ssh_host': resource_attributes['ip_address'],
    #    'ip4address' : resource_attributes['ip_address'],
    #    'provider': 'exoscale',
    #}
#
    #role = 'none'
#
    #if 'kube-role' in meta_data:
    #    role = meta_data.get('kube-role')
    #else:
    #    for group in groups:
    #        if group in name:
    #            role = group
#
    #attrs.update({
    #    'kube_role': role
    #})
#
    #return name, attrs

def main():
    resource_parser_iter(build_resource_iter_from_files(find_state_files()))


if __name__ == '__main__':
    main()
