{
   pkgs, 
  ...
}:
{

environment.systemPackages = with pkgs; [ iproute2 ];

#Bufferbloat 0 ms (1gbps)
networking.localCommands = ''
  # Detect the default network interface (e.g. eno1, eth0, wlan0, etc.)
  WANIF="$(${pkgs.iproute2}/bin/ip route show default | ${pkgs.gnugrep}/bin/grep -oP 'dev \K\S+')"

  # If no interface was found, exit early
  [ -n "$WANIF" ] || exit 0

  # Remove any existing qdiscs (to avoid duplication or conflicts)
  ${pkgs.iproute2}/bin/tc qdisc del dev "$WANIF" root || true
  ${pkgs.iproute2}/bin/tc qdisc del dev ifb0 root || true

  # Create the ifb0 interface if it does not exist (used for ingress shaping)
  ${pkgs.iproute2}/bin/ip link show ifb0 > /dev/null 2>&1 || \
    ${pkgs.iproute2}/bin/ip link add name ifb0 type ifb
  ${pkgs.iproute2}/bin/ip link set dev ifb0 up

  # Apply Cake qdisc on the WAN interface for upload shaping
  ${pkgs.iproute2}/bin/tc qdisc add dev "$WANIF" root cake \
    bandwidth 925Mbit diffserv4 triple-isolate nat wash ack-filter overhead 44

  # Redirect ingress traffic to ifb0 (to enable download shaping)
  ${pkgs.iproute2}/bin/tc qdisc add dev "$WANIF" handle ffff: ingress
  ${pkgs.iproute2}/bin/tc filter add dev "$WANIF" parent ffff: protocol ip u32 match u32 0 0 \
    flowid 1:1 action mirred egress redirect dev ifb0

  # Apply Cake qdisc on ifb0 for download shaping
  ${pkgs.iproute2}/bin/tc qdisc add dev ifb0 root cake \
    bandwidth 925Mbit diffserv4 triple-isolate nat wash overhead 44
'';

}
