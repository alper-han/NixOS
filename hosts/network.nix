{ ... }:
{

  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    "net.core.wmem_max" = 1073741824;
    "net.core.rmem_max" = 1073741824;

    #https://nixsanctuary.com/linux-network-performance-optimization-tips-for-optimizing-linux-network-throughput-and-latency/
    "net.ipv4.tcp_rmem" = "16777216 16777216 16777216";
    "net.ipv4.tcp_wmem" = "16777216 16777216 16777216";
    "net.core.netdev_max_backlog" = "25000";
    "net.ipv4.tcp_low_latency" = "1";
    "net.ipv4.tcp_fin_timeout" = "10";
    #            "net.ipv4.tcp_limit_output_bytes" = "131072";
    "net.ipv4.tcp_max_tw_buckets" = "450000";
    "net.ipv4.tcp_window_scaling" = "1";

    #            "net.ipv6.conf.all.disable_ipv6" = "1";
    #            "net.ipv6.conf.default.disable_ipv6" = "1";

  };
}
