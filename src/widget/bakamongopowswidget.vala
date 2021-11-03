namespace Bakamon {
    public class GoPowsWidget : Gtk.DrawingArea {
        private int width = 264;
        
        public int pows_count {
            get {
                return pows_count_value;
            }
            set {
                pows_count_value = value;
                height_request = (pows_count / 8 + (pows_count % 8 > 0 ? 1 : 0)) * (width / 8);
                queue_draw();
            }
        }
        
        private int pows_count_value = 0;
        private GoStatus status;
        private BallDrawer drawer;
        
        public GoPowsWidget(GoStatus status) requires(status == BLACK || status == WHITE) {
            this.status = status;
            drawer = new BallDrawer();
            drawer.set_color(status);
        }
        
        public override bool draw(Cairo.Context cairo) {
            int num_in_row = 10;
            int cell_width = width / num_in_row;
            int radius = cell_width / 2 - 1;
            drawer.set_radius(radius);
            for (int i = 0; i < pows_count_value; i++) {
                var p = DPoint() {
                    x = (double) ((i % num_in_row) * cell_width + radius),
                    y = (double) ((i / num_in_row) * cell_width + radius)
                };
                drawer.move_to(p);
                drawer.draw(cairo);
            }
            return true;
        }
    }
}
