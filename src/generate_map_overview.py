from pathlib import Path

import click

import matplotlib.pyplot as plt
import numpy as np

import av2.rendering.vector as vector_plotting_utils
from av2.map.map_api import ArgoverseStaticMap

# scaled to [0,1] for matplotlib.
PURPLE_RGB = [201, 71, 245]
PURPLE_RGB_MPL = np.array(PURPLE_RGB) / 255

DARK_GRAY_RGB = [40, 39, 38]
DARK_GRAY_RGB_MPL = np.array(DARK_GRAY_RGB) / 255


def single_log_teaser(
        argoverse_scenario_dir: Path,
        viz_output_dir: Path,
) -> None:
    """
    For a single log, render all local crosswalks in green, and pedestrian crossings in purple,
    in a bird's eye view.
    """
    avm = ArgoverseStaticMap.from_map_dir(
        argoverse_scenario_dir, build_raster=False)

    fig = plt.figure(figsize=(10, 10))
    ax = fig.add_subplot()

    for _, ls in avm.vector_lane_segments.items():
        # right_ln_bnd
        # left_ln_bnd
        vector_plotting_utils.draw_polygon_mpl(
            ax, ls.polygon_boundary, color="g", linewidth=0.5)
        vector_plotting_utils.plot_polygon_patch_mpl(
            ls.polygon_boundary, ax, color="g", alpha=0.2)

    # plot all pedestrian crossings
    for _, pc in avm.vector_pedestrian_crossings.items():
        vector_plotting_utils.draw_polygon_mpl(
            ax, pc.polygon, color="m", linewidth=0.5)
        vector_plotting_utils.plot_polygon_patch_mpl(
            pc.polygon, ax, color="m", alpha=0.2)

    scenario_id = argoverse_scenario_dir.stem.split("_")[-1]
    plt.savefig(f"{viz_output_dir}/{scenario_id}.png")


@click.command(help="Generate visualizations from a directory of Argoverse scenarios.")
@click.option(
    "--argoverse-scenario-dir",
    required=True,
    help="Path to local directory where Argoverse scenarios are stored.",
    type=click.Path(exists=True),
)
@click.option(
    "--viz-output-dir",
    required=True,
    help="Path to local directory where generated visualizations should be saved.",
    type=click.Path(),
)
def run_single_log_teaser(
    argoverse_scenario_dir: str,
    viz_output_dir: str,
) -> None:
    """Click entry point for generation of Argoverse scenario visualizations."""
    single_log_teaser(
        Path(argoverse_scenario_dir),
        Path(viz_output_dir),
    )


if __name__ == "__main__":
    run_single_log_teaser()
