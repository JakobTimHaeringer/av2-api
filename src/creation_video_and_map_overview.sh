#/usr/bin/bash

conda activate /home/haj3st/miniconda3/envs/av2/envs/av2

echo "Creating map overview and scenario video visualisation"

# Dataroot
dataroot='/mnt/ssd/tagged_trajectory_prediction_artifacts/2024_04_15_argoverse_processed/'

# List of scenario directories
scenario_ids=(
    "34510876-cf7f-414d-9d5d-dca5c3a111d6/"
    "34554d42-78bc-455b-932f-19ade1c7b4e7/"
    "345b7565-cd57-485f-b200-bd99e8565ad4/"
    "345f82e3-e9c0-4c8f-ac1f-b0b79d8ff3f9/"
)

output_dir='/home/haj3st/av2-api/results'

# Loop through the scenario directories
for dir in "${scenario_ids[@]}"
do
    full_dir="${dataroot}${dir}"
    python3 generate_forecasting_scenario_visualizations.py --argoverse-scenario-dir "$full_dir" --viz-output-dir "$output_dir"
    python3 generate_map_overview.py --argoverse-scenario-dir "$full_dir" --viz-output-dir "$output_dir"
done

echo "Map overview and scenario video visualisation has been created!"